import 'dart:async';

import 'package:d_box/objectbox.g.dart';
import 'package:d_box/src/feature/vault/vault_dao.dart';
import 'package:d_box/src/feature/vault/vault_dao_object_box_impl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { masterPassSign }

class ServiceLocator {
  ServiceLocator._ctor();

  static final instance = ServiceLocator._ctor();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    store = await openStore(directory: p.join(dir.path, 'obx_store'));
  }

  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get sharedPreferences async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  VaultDao? _vaultDao;

  VaultDao get vaultDao {
    _vaultDao ??= VaultDaoObjectBoxImpl();
    return _vaultDao!;
  }

  late Store store;
}