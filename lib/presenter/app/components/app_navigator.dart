import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:flutter/material.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Routes.shellKey,
      initialRoute: route,
      onGenerateRoute: Routes.onGenerateAppShellRoute,
    );
  }
}
