import 'package:crypto_wallet/domain/models/app_user.dart';

abstract interface class LocalStorage {
  static const userStorageKey = 'user';

  AppUser? getUser();
  Future<void> setUser(AppUser user);
  Future<void> clear();
}
