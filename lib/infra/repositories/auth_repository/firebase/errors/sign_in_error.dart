import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';

/// {@template firebase_sign_in_error}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class FirebaseSignInError extends ExternalError {
  /// {@macro firebase_sign_in_error}
  FirebaseSignInError({String? message, StackTrace? trace})
      : super(message ?? AppLocalizations.current.errorUnknowError,
            trace: trace);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory FirebaseSignInError.fromCode(String code, [StackTrace? trace]) {
    switch (code) {
      case 'account-exists-with-different-credential:':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorThereIsAnotherAccount,
          trace: trace,
        );
      case 'invalid-credential':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorCredentialIsInvalid,
          trace: trace,
        );
      case 'invalid-verification-code':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorVerificationCodeIsInvalid,
          trace: trace,
        );
      case 'invalid-verification-id':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorVerificationIdIsInvalid,
          trace: trace,
        );
      case 'operation-not-allowed':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorMethodNotAllowed,
          trace: trace,
        );
      case 'invalid-email':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorEmailIsInvalid,
          trace: trace,
        );
      case 'user-disabled':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorUserHasBeenDisabled,
          trace: trace,
        );
      case 'user-not-found':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorEmailWasNotFound,
          trace: trace,
        );
      case 'wrong-password':
        return FirebaseSignInError(
          message: AppLocalizations.current.errorIncorrectEmailOrPassword,
          trace: trace,
        );
      default:
        return FirebaseSignInError(trace: trace);
    }
  }
}
