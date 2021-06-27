import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc {
  Future<void> signIn(Auth auth) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'photoUrl']);
    try {
      final response = await _googleSignIn.signIn();
      final user = User(
        name: response!.displayName!,
        photoUrl: response.photoUrl,
        email: response.email, 
        uid: '',
      );
      auth.setUser(user);
    } catch (error) {
      print(error);
    }
  }
}
