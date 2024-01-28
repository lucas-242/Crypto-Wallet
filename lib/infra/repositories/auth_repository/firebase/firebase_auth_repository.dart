import 'dart:io';

import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/utils/log_utils.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:crypto_wallet/domain/repositories/auth_repository.dart';
import 'package:crypto_wallet/infra/repositories/auth_repository/firebase/errors/sign_in_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    GoogleSignIn? googleSignIn,
    FirebaseAuth? firebaseAuth,
  })  : googleSignIn = googleSignIn ?? GoogleSignIn(),
        firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final response = await firebaseAuth.signInWithCredential(credential);
      return response.user?.toAppUser();
    } on SocketException {
      Log.error('Error to sign in: No internet available');
      throw NoConnectionError('Error to sign in: No internet available');
    } on FirebaseAuthException catch (error) {
      Log.error('Error to sign in: ${error.code}');
      throw FirebaseSignInError.fromCode(error.code, error.stackTrace);
    } catch (error) {
      Log.error('Error to sign in: ${error.toString()}');
      throw FirebaseSignInError();
    }
  }

  @override
  Stream<AppUser?> userChanges() =>
      firebaseAuth.userChanges().map((user) => user?.toAppUser());

  @override
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } on SocketException {
      Log.error('Error to sign out: No internet available');
      throw NoConnectionError('Error to sign out: No internet available');
    } on FirebaseAuthException catch (error) {
      Log.error('Error to sign out: ${error.code}');
      throw FirebaseSignInError.fromCode(error.code, error.stackTrace);
    } catch (error) {
      Log.error('Error to sign out: ${error.toString()}');
      throw FirebaseSignInError();
    }
  }
}
