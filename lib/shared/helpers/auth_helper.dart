import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Helper to handle auth operations
abstract class AuthHelper {
  /// Sign out using the [auth] and [context] instances to perform the action, erase all data and redirect the user
  static void signOut({required BuildContext context, required Auth auth}) {
    auth.signOut().then((value) {
      if (value) {
        context.read<TradesBloc>().eraseData();
        context.read<WalletBloc>().eraseData();
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        getAppSnackBar(
            message: 'Error trying to logout',
            type: SnackBarType.error,
            onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      );
    });
  }
}
