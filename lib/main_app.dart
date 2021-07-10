import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/shared/themes/app_colors.dart';

import 'modules/app/app.dart';
import 'modules/login/login.dart';
import 'modules/splash/splash_page.dart';
import 'modules/insert_trade/insert_trade.dart';
import 'modules/trades/trades.dart';
import 'modules/wallet/wallet.dart';
import 'repositories/coin_repository.dart';
import 'repositories/wallet_repository.dart';

class MainApp extends StatelessWidget {
  MainApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  final walletRepository = WalletRepository();
  final coinRepository = CoinRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppBloc()),
        ChangeNotifierProvider(
            create: (_) => TradesBloc(walletRepository: walletRepository)),
        ChangeNotifierProvider(
          create: (_) => WalletBloc(
            walletRepository: walletRepository,
            coinRepository: coinRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Crypto Wallet',
        theme: ThemeData(
            primaryColor: AppColors.primary,
            primarySwatch:
                MaterialColor(0xFF264653, AppColors.primaryMaterial)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashPage(),
          '/app': (context) => App(),
          '/login': (context) => LoginPage(),
          '/insert_trade': (context) => InsertTradePage(
                walletRepository: walletRepository,
              )
        },
      ),
    );
  }
}
