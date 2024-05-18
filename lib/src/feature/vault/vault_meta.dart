import 'package:cryptography/helpers.dart';
import 'package:d_box/objectbox.g.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class VaultMeta {
  @Id()
  int id;
  @Unique()
  bool dummy;
  List<int> masterNonce;

  VaultMeta()
      : id = 0,
        dummy = true,
        masterNonce = randomBytes(16);
}

class VaultMetaService {
  final Box<VaultMeta> _box;
  late final Query<VaultMeta> _metaQuery;

  VaultMetaService() : _box = ServiceLocator.instance.store.box<VaultMeta>() {
    _metaQuery = _box.query().build();
  }

  Future<VaultMeta> get meta async {
    final meta = await _metaQuery.findFirstAsync();
    if (meta != null) {
      return meta;
    }
    final newMeta = VaultMeta();
    await _box.putAsync(newMeta);
    return newMeta;
  }
}
