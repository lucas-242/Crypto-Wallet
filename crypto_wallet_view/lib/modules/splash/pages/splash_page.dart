import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/core/routes.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';

final _auth = FirebaseAuth.instance;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late StreamSubscription<User?> userStream;

  @override
  void initState() {
    userStream = _auth.userChanges().listen((user) {
      if (user != null) {
        final auth = context.read<Auth>();
        auth.user = user;
        Navigator.pushReplacementNamed(context, AppRoutes.app);
        userStream.cancel();
      } else
        Navigator.pushReplacementNamed(context, AppRoutes.login);
    });

    super.initState();
  }

  @override
  void dispose() {
    userStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Crypto',
              style: textTheme.headline1!.copyWith(color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              'Wallet',
              style: textTheme.headline1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
