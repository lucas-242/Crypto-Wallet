import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/domain/data/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorage implements LocalStorage {
  SharedPreferencesLocalStorage(this._prefs);
  late final SharedPreferences _prefs;

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> set<T>(String key, T value) {
    switch (T) {
      case String:
        return _prefs.setString(key, value as String);
      case bool:
        return _prefs.setBool(key, value as bool);
      case int:
        return _prefs.setInt(key, value as int);
      default:
        throw ClientError('No support for the data type ${T.runtimeType}');
    }
  }

  @override
  T? get<T>(String key) {
    switch (T) {
      case String:
        return _prefs.getString(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      case int:
        return _prefs.getInt(key) as T?;
      case Object:
        return _prefs.get(key) as T?;
      default:
        throw ClientError('No support for the data type ${T.runtimeType}');
    }
  }
}
