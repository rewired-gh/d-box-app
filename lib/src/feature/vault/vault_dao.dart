import 'package:d_box/src/feature/vault/encrypted_item.dart';
import 'package:d_box/src/feature/vault/encrypted_item_meta.dart';

abstract class VaultDao {
  static const magicSeq = [19, 84];
  List<int>? cachedMasterHash;

  Future<bool> tryUnlock(String password);

  Future<List<EncryptedItemMeta>> get allItemMetas;

  Future<EncryptedItemMeta> createNewItem(String? name);

  Future<EncryptedItem> getItemById(int id);

  Future<void> removeItemById(int metaId);

  Future<void> setItem(EncryptedItemMeta meta, EncryptedItem item);

  Future<bool> get isMasterPassSet;
}
