import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_wallet/shared/themes/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:crypto_wallet/modules/app/app.dart';
import 'package:crypto_wallet/modules/insert_trade/insert_trade.dart';
import 'package:crypto_wallet/modules/login/login.dart';
import 'package:crypto_wallet/modules/splash/splash.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';

import 'app_scaffold_widget.dart';

/// Widget that is the Material App
class App extends StatefulWidget {
  final WalletRepository walletRepository;
  const App({
    Key? key,
    required this.walletRepository,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppThemes.lightTheme,
      dark: AppThemes.darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Crypto Wallet',
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (context) => SplashPage(),
          AppRoutes.app: (context) => AppScaffold(),
          AppRoutes.login: (context) => LoginPage(),
          AppRoutes.tradesDetails: (context) => TradesDetails(),
          AppRoutes.tradesInsert: (context) => InsertTradePage(
                walletRepository: widget.walletRepository,
              ),
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
