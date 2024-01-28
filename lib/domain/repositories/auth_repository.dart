import 'package:crypto_wallet/domain/models/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser?> signInWithGoogle();
  Stream<AppUser?> userChanges();
  Future<void> signOut();
}
