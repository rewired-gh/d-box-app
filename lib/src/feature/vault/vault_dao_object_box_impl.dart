import 'package:d_box/objectbox.g.dart';
import 'package:d_box/src/feature/crypt/password_hash.dart';
import 'package:d_box/src/feature/vault/encrypted_item.dart';
import 'package:d_box/src/feature/vault/vault_dao.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/foundation.dart';

class VaultDaoObjectBoxImpl extends VaultDao {
  late final Query<EncryptedItem> _signItemQuery;

  final Box<EncryptedItem> _box;

  VaultDaoObjectBoxImpl()
      : _box = ServiceLocator.instance.store.box<EncryptedItem>() {
    _signItemQuery = _box.query(EncryptedItem_.isSign.equals(true)).build();
  }

  Future<EncryptedItem?> get _signItem => _signItemQuery.findFirstAsync();

  List<int>? _cachedMasterHash;

  @override
  Future<bool> tryUnlock(String password) async {
    final meta = await ServiceLocator.instance.vaultMetaService.meta;
    final sign = await _signItem;
    final hash = await PasswordHash(password, meta.masterNonce).hash;
    _cachedMasterHash = hash;

    if (sign == null) {
      final newSign = EncryptedItem(isSign: true);
      newSign.setContent(hash, VaultDao.magicSeq);
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
  Future<bool> get isMasterPassSet async => await _signItem != null;
}
