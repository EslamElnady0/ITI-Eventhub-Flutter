import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  const LocalStorageHelper(this._preferences, this._secureStorage);

  final SharedPreferences _preferences;
  final FlutterSecureStorage _secureStorage;

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  bool? getBool(String key) => _preferences.getBool(key);

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  String? getString(String key) => _preferences.getString(key);

  Future<bool> remove(String key) => _preferences.remove(key);

  Future<void> writeSecure(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecure(String key) {
    return _secureStorage.read(key: key);
  }

  Future<void> deleteSecure(String key) {
    return _secureStorage.delete(key: key);
  }
}
