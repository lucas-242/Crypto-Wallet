import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/presenter/home/pages/home.dart';
import 'package:crypto_wallet/presenter/login/pages/login_page.dart';
import 'package:crypto_wallet/presenter/splash/pages/splash_page.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeSettings.light(),
      darkTheme: ThemeSettings.dark(),
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      initialRoute: Routes.app,
      routes: {
        Routes.app: (context) => const SplashPage(),
        Routes.login: (context) => const LoginPage(),
        Routes.home: (context) => const HomePage(),
        Routes.trades: (context) => Container(),
        Routes.addTrade: (context) => Container(),
      },
    );
  }
}
