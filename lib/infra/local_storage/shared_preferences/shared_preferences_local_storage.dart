import 'dart:convert';

import 'package:crypto_wallet/domain/data/local_storage.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorage implements LocalStorage {
  SharedPreferencesLocalStorage(this._prefs);
  late final SharedPreferences _prefs;

  @override
  Future<void> clear() => _prefs.remove(LocalStorage.userStorageKey);

  @override
  AppUser? getUser() {
    final fromStorage = _prefs.getString(LocalStorage.userStorageKey);
    if (fromStorage != null) return AppUser.fromJson(jsonDecode(fromStorage));

    return null;
  }

  @override
  Future<void> setUser(AppUser user) =>
      _prefs.setString(LocalStorage.userStorageKey, jsonEncode(user.toJson()));
}
