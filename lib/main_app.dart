import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'blocs/wallet/wallet.dart';
import 'modules/app/app.dart';
import 'modules/login/login.dart';
import 'modules/splash/splash_page.dart';
import 'modules/insert_trade/insert_trade.dart';
import 'modules/trades/trades.dart';
import 'repositories/coin_repository/coin_repository.dart';
import 'repositories/wallet_repository/wallet_repository.dart';
import 'shared/auth/auth.dart';

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
        ChangeNotifierProvider(create: (_) => Auth()),
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
          primarySwatch: AppColors.primarySwatch,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (context) => SplashPage(),
          AppRoutes.app: (context) => App(),
          AppRoutes.login: (context) => LoginPage(),
          AppRoutes.tradesDetails: (context) => TradesDetails(),
          AppRoutes.tradesInsert: (context) => InsertTradePage(
                walletRepository: walletRepository,
              ),
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
