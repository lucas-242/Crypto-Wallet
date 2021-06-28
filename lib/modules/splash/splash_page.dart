import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    auth.userChanges().listen((user) {
      if (user != null)
        Navigator.pushReplacementNamed(context, '/app', arguments: user);
      else
        Navigator.pushReplacementNamed(context, '/login');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Crypto',
              style: AppTextStyles.titleHome.copyWith(color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              'Wallet',
              style: AppTextStyles.titleHome,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
