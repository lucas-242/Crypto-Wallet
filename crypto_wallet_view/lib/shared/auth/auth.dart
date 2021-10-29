import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends ChangeNotifier {
  User? user;

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return false;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((response) {
      user = response.user;
      return true;
    }).catchError((error) {
      user = null;
      print('Error trying to login: ${error.toString()}');
      return false;
    });
  }

  Future<bool> signOut() async {
    return await GoogleSignIn().signOut().then((value) async {
      return await FirebaseAuth.instance.signOut().then((value) {
        user = null;
        return true;
      }).catchError((error) => false);
    }).catchError((error) => false);
  }
}
