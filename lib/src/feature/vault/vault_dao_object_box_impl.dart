import 'package:d_box/objectbox.g.dart';
import 'package:d_box/src/feature/vault/encrypted_item.dart';
import 'package:d_box/src/feature/vault/vault_dao.dart';
import 'package:d_box/src/util/service_locator.dart';

class VaultDaoObjectBoxImpl extends VaultDao {
  final Box<EncryptedItem> _box =
      ServiceLocator.instance.store.box<EncryptedItem>();

  Future<EncryptedItem?> get _signItem =>
      _box.query(EncryptedItem_.isSign.equals(true)).build().findFirstAsync();

  @override
  Future<void> tryUnlock(String password) async {}

  @override
  Future<bool> get isMasterPassSet async => await _signItem != null;
}
