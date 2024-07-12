
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_base.dart';

class LocalStorage implements LocalStorageBase {
  late final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  @override
  Future<void> write(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  String? read(String key) {
    return _prefs.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}