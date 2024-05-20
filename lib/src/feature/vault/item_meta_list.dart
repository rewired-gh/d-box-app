import 'package:d_box/src/feature/vault/encrypted_item.dart';
import 'package:d_box/src/feature/vault/encrypted_item_meta.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_meta_list.g.dart';

@riverpod
class ItemMetaList extends _$ItemMetaList {
  @override
  Future<List<EncryptedItemMeta>> build() async {
    return await ServiceLocator.instance.vaultDao.allItemMetas;
  }

  Future<EncryptedItemMeta> createNewItem(String name) async {
    final s = ServiceLocator.instance;
    final meta = await s.vaultDao.createNewItem(name);
    ref.invalidateSelf();
    await future;
    return meta;
  }

  Future<void> removeItemById(int metaId) async {
    final s = ServiceLocator.instance;
    await s.vaultDao.removeItemById(metaId);
    ref.invalidateSelf();
    await future;
  }

  Future<void> setItem(EncryptedItemMeta meta, EncryptedItem item) async {
    final s = ServiceLocator.instance;
    await s.vaultDao.setItem(meta, item);
    ref.invalidateSelf();
    await future;
  }
}
