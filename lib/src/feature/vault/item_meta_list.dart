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

  Future<void> createNewItem(String name) async {
    final s = ServiceLocator.instance;
    await s.vaultDao.createNewItem(name);
    ref.invalidateSelf();
    await future;
  }

  Future<void> removeItemById(int metaId) async {
    final s = ServiceLocator.instance;
    await s.vaultDao.removeItemById(metaId);
    ref.invalidateSelf();
    await future;
  }
}
