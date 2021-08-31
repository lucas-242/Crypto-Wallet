import 'dart:async';

import 'package:crypto_wallet/shared/helpers/crypto_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_wallet/repositories/coin_repository/coin_repository.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';

final _auth = FirebaseAuth.instance;

class SplashPage extends StatefulWidget {
  final CoinRepository coinRepository;
  const SplashPage({
    Key? key,
    required this.coinRepository,
  }) : super(key: key);

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

        //TODO: This call can consume a lot of time to init the app. Consider to create alternative ways to load the app
        widget.coinRepository.getCoinsByMarketcap().then((value) {
          CryptoHelper.setCoinsList(marketcapData: value);
          Navigator.pushReplacementNamed(context, AppRoutes.app);
        });

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
