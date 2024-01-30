import 'package:crypto_wallet/presenter/app/app_shell.dart';
import 'package:crypto_wallet/presenter/home/pages/home_page.dart';
import 'package:crypto_wallet/presenter/login/pages/login_page.dart';
import 'package:crypto_wallet/presenter/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';

export 'routes_extensions.dart';

abstract class Routes {
  static const splash = '/splash/';
  static const login = '/login/';
  static const home = '/';
  static const wallet = '/wallet/';
  static const trades = '/trades/';
  static const addTrade = '${trades}add/';

  static final globalKey = GlobalKey<NavigatorState>(debugLabel: 'Global Key');
  static late GlobalKey<NavigatorState> shellKey;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;

    if (settings.name == Routes.login) {
      page = const LoginPage();
    } else if (settings.name == Routes.splash) {
      page = const SplashPage();
    } else {
      final subRoute = settings.name!.substring(1);
      page = AppShell(route: subRoute);
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,
    );
  }

  static Route<dynamic>? onGenerateAppShellRoute(RouteSettings settings) {
    final Widget page;

    switch (settings.name) {
      case Routes.home:
        page = const HomePage();
      case Routes.wallet:
        page = Container(color: Colors.green);
      default:
        page = Container(
          color: Colors.blue,
        );
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,
    );
  }
}
