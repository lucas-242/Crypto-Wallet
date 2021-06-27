import 'package:crypto_wallet/shared/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  User? _user;

  User get user => _user!;

  Future<User?> currentUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (preferences.containsKey('user')) {
      final user = preferences.get('user') as String;
      setUser(User.fromJson(user));
      return _user;
    }

    setUser(null);
  }

  void setUser(User? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
    }
  }

  void saveUser(User user) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('user', user.toJson());
    return;
  }
}
