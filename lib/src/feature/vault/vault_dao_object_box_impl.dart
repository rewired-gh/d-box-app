import 'package:d_box/objectbox.g.dart';
import 'package:d_box/src/feature/crypt/password_hash.dart';
import 'package:d_box/src/feature/vault/encrypted_item.dart';
import 'package:d_box/src/feature/vault/encrypted_item_meta.dart';
import 'package:d_box/src/feature/vault/vault_dao.dart';
import 'package:d_box/src/util/debug.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/foundation.dart';

class VaultDaoObjectBoxImpl extends VaultDao {
  late final Query<EncryptedItem> _signItemQuery;
  late final Query<EncryptedItemMeta> _allMetasQuery;
  late final Query<EncryptedItem> _itemQuery;
  late final Query<EncryptedItemMeta> _metaQuery;

  final Box<EncryptedItem> _box;
  final Box<EncryptedItemMeta> _metaBox;

  VaultDaoObjectBoxImpl()
      : _box = ServiceLocator.instance.store.box<EncryptedItem>(),
        _metaBox = ServiceLocator.instance.store.box<EncryptedItemMeta>() {
    _signItemQuery = _box.query(EncryptedItem_.isSign.equals(true)).build();
    _allMetasQuery = _metaBox
        .query()
        .order(
          EncryptedItemMeta_.createdDate,
          flags: Order.descending,
        )
        .build();
    _itemQuery = _box.query(EncryptedItem_.id.equals(0)).build();
    _metaQuery = _metaBox.query(EncryptedItemMeta_.id.equals(0)).build();
  }

  Future<EncryptedItem?> get _signItem => _signItemQuery.findFirstAsync();

  @override
  Future<bool> tryUnlock(String password) async {
    final meta = await ServiceLocator.instance.vaultMetaService.meta;
    final sign = await _signItem;
    final hash = await PasswordHash(password, meta.masterNonce).hash;
    cachedMasterHash = hash;

    if (kDebugMode) {
      await kDebugDelay();
    }

    if (sign == null) {
      final newSign = EncryptedItem(isSign: true);
      await newSign.setContent(hash, VaultDao.magicSeq);
      await _box.putAsync(newSign);
      return true;
    }

    final auth = await sign.getContent(hash);
    if (auth == null) {
      return false;
    }
    return listEquals(auth, VaultDao.magicSeq);
  }

  @override
  Future<List<EncryptedItemMeta>> get allItemMetas =>
      _allMetasQuery.findAsync();

  @override
  Future<EncryptedItemMeta> createNewItem(name) async {
    final newItem = await _box.putAndGetAsync(EncryptedItem());
    final newMeta = await _metaBox.putAndGetAsync(
        EncryptedItemMeta(itemId: newItem.id, name: name ?? ""));
    if (kDebugMode) {
      await kDebugDelay();
    }
    return newMeta;
  }

  @override
  Future<EncryptedItem> getItemById(int id) async {
    _itemQuery.param(EncryptedItem_.id).value = id;
    final item = await _itemQuery.findFirstAsync();
    if (item == null) {
      throw Exception(); // TODO
    }
    if (kDebugMode) {
      await kDebugDelay();
    }
    return item;
  }

  @override
  Future<void> removeItemById(int metaId) async {
    _metaQuery.param(EncryptedItemMeta_.id).value = metaId;
    final itemId = _metaQuery.property(EncryptedItemMeta_.itemId).find().first;
    await _box.removeAsync(itemId);
    await _metaBox.removeAsync(metaId);
    if (kDebugMode) {
      await kDebugDelay();
    }
  }

  @override
  Future<void> setItem(EncryptedItemMeta meta, EncryptedItem item) async {
    await _metaBox.putAsync(meta);
    await _box.putAsync(item);
    if (kDebugMode) {
      await kDebugDelay();
    }
  }

  @override
  Future<bool> get isMasterPassSet async => await _signItem != null;

  @override
  Future<void> resetAll() async {
    await _box.removeAllAsync();
    await _metaBox.removeAllAsync();
    if (kDebugMode) {
      await kDebugDelay();
    }
  }
}
