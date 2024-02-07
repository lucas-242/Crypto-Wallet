import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/presenter/app/pages/app_shell.dart';
import 'package:crypto_wallet/presenter/app/pages/splash_page.dart';
import 'package:crypto_wallet/presenter/home/pages/home_page.dart';
import 'package:crypto_wallet/presenter/login/pages/login_page.dart';
import 'package:crypto_wallet/presenter/trades/pages/trades_page.dart';
import 'package:crypto_wallet/presenter/wallet/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class RoutesConfig {
  static final router = GoRouter(
    initialLocation: Routes.splash,
    navigatorKey: Routes.globalKey,
    routes: [
      GoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) =>
            _customTransition(state, const SplashPage()),
      ),
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) =>
            _customTransition(state, const LoginPage()),
      ),
      _appShellRoutes,
    ],
  );

  static final _appShellRoutes = ShellRoute(
    navigatorKey: Routes.shellKey,
    builder: (context, state, child) => AppShell(child: child),
    routes: [
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) =>
            _customTransition(state, const HomePage()),
      ),
      GoRoute(
        path: Routes.wallet,
        pageBuilder: (context, state) =>
            _customTransition(state, const WalletPage()),
      ),
      GoRoute(
        path: Routes.trades,
        pageBuilder: (context, state) =>
            _customTransition(state, const TradesPage()),
      ),
    ],
  );

  static CustomTransitionPage<Widget> _customTransition(
      GoRouterState state, Widget child) {
    final Tween<Offset> bottomUpTween = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    );
    final Animatable<double> fastOutSlowInTween =
        CurveTween(curve: Curves.fastOutSlowIn);
    final Animatable<double> easeInTween = CurveTween(curve: Curves.easeIn);

    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(bottomUpTween.chain(fastOutSlowInTween)),
          child: FadeTransition(
            opacity: easeInTween.animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
