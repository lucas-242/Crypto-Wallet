import 'package:crypto_wallet/core/components/custom_snack_bar/custom_snack_bar.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/core/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RoutesExtensions on BuildContext {
  void navigateTo(String route) {
    Log.navigation('Navigating to $route');
    go(route);
  }

  void pushTo(String route, {Object? params}) {
    Log.navigation('Navigating to pushed route $route with params: $params');
    push(route, extra: params);
  }

  void pop() {
    Log.navigation('Route poped');
    GoRouter.of(this).pop();
  }

  void showSnackBar(String title) {
    Log.navigation('''Showing snack bar:
    title: $title,
    ''');
    getCustomSnackBar(this, title: title);
  }

  void showDrawer() {
    Log.navigation('Opening Drawer');
    Scaffold.of(Routes.shellKey.currentContext!).openDrawer();
  }

  // void showDialog({
  //   double? width,
  //   required String title,
  //   required String description,
  // }) {
  //   Log.navigation('''Showing dialog:
  //   child: $title : $description,
  //   ''');
  //   showBaseDialog(
  //     context: this,
  //     width: width,
  //     title: title,
  //     description: description,
  //   );
  // }

  // Future<T?> showBottomSheet<T>({
  //   required String title,
  //   required String description,
  //   required String confirmText,
  //   required String denyText,
  //   required VoidCallback onConfirm,
  // }) {
  //   Log.navigation('''Showing bottom sheet:
  //   title: $title,
  //   description: $description,
  //   ''');
  //   return showCustomBottomSheet<T>(
  //     context: this,
  //     title: title,
  //     description: description,
  //     confirmText: confirmText,
  //     denyText: denyText,
  //     onConfirm: onConfirm,
  //   );
  // }
}
