import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { isMasterPassSet }

class PrefRepo {
  PrefRepo._privateConstructor();

  static final instance = PrefRepo._privateConstructor();

  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get sharedPreferences async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<bool> getIsMasterPassSet() async {
    final prefs = await sharedPreferences;
    return prefs.getBool(PrefKeys.isMasterPassSet.name) ?? false;
  }

  Future<void> setIsMasterPassSet(bool value) async {
    final prefs = await sharedPreferences;
    await prefs.setBool(PrefKeys.isMasterPassSet.name, value);
  }
}
