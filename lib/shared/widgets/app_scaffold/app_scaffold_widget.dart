import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/app/app.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:crypto_wallet/shared/widgets/custom_drawer/custom_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Auth auth;
  final Widget? body;
  final List<Widget>? appBarActions;
  const AppScaffold({
    Key? key,
    this.body,
    required this.title,
    required this.scaffoldKey,
    required this.auth,
    this.appBarActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    void signOut() {
      auth.signOut().then((value) {
        if (value) {
          context.read<TradesBloc>().eraseData();
          context.read<WalletBloc>().eraseData();
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          getAppSnackBar(
              message: appLocalizations.errorLogout,
              type: SnackBarType.error,
              onClose: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar()),
        );
      });
    }

    void changeTheme() {
      context.read<AppBloc>().changeTheme(AdaptiveTheme.of(context));
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: CustomDrawer(
          onPressedDarkMode: () => changeTheme(),
          onPressedLogout: () => signOut(),
        ),
      ),
      appBar: CustomAppBar(
        title: title,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: AppColors.grey,
          onPressed: () {
            scaffoldKey.currentState!.openDrawer(); // this opens drawer
          },
        ),
        actions: appBarActions,
      ),
      body: body,
    );
  }
}
