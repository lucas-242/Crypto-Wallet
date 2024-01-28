import 'package:crypto_wallet/app_store.dart';
import 'package:crypto_wallet/core/components/custom_snack_bar/custom_snack_bar.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _store = ServiceLocator.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return ReactionBuilder(
      builder: (context) {
        return when((_) => _store.userStream.value != null,
            () => context.navigateTo(Routes.home));
      },
      child: Scaffold(
        body: Column(
          children: [
            const Spacer(),
            Center(
              child: Text(
                'Crypto',
                style: context.textTitleXXLg.copyWith(color: AppColors.primary),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'Wallet',
                style: context.textTitleXXLg,
                textAlign: TextAlign.center,
              ),
            ),
            AppSpacings.verticalLg,
            Text(
              AppLocalizations.current.logo,
              textAlign: TextAlign.center,
              style: context.textTitleLg,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Google'),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() {
    ServiceLocator.get<AppStore>().signInWithGoogle().catchError((error) {
      getCustomSnackBar(context, title: error.message);
    });
    // ServiceLocator.get<AppStore>().signInWithGoogle().then((user) {
    //   if (user != null) context.navigateTo(Routes.home);
    // }).catchError((error) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     getAppSnackBar(
    //         message: AppLocalizations.current.error,
    //         type: SnackBarType.error,
    //         onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
    //   );
    // });
  }
}
