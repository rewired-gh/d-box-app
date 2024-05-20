import 'package:d_box/src/util/service_locator.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  @Id()
  int id;
  @Unique()
  bool dummy;
  String? languageCode;
  String? regionCode;

  Settings({
    this.languageCode,
    this.regionCode,
  })  : id = 0,
        dummy = true;
}

class SettingsService {
  final Box<Settings> _box;
  late final Query<Settings> _settingsQuery;
  late final Settings _settings;

  SettingsService() : _box = ServiceLocator.instance.store.box<Settings>() {
    _settingsQuery = _box.query().build();
    _settings = _settingsQuery.findFirst() ?? Settings();
  }

  Settings get settings {
    return _settings;
  }

  Future<void> persistSettings() async {
    await _box.removeAllAsync();
    await _box.putAsync(_settings);
  }
}
