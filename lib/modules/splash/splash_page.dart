import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    final auth = context.read<Auth>();
    auth.currentUser().then((user) {
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
