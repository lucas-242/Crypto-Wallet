import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/social_login_button/social_login_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AppLocalizations appLocalizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context)!;
  }

  void _login() {
    context.read<Auth>().signInWithGoogle().then((value) {
      if (value) Navigator.of(context).pushReplacementNamed(AppRoutes.app);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        getAppSnackBar(
            message: appLocalizations.errorLogin,
            type: SnackBarType.error,
            onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context, kBottomNavigationBarHeight);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: SizeConfig.width,
        height: SizeConfig.height,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.height * 0.3),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Crypto',
                      style: textTheme.headline1!
                          .copyWith(color: AppColors.primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Wallet',
                      style: textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100, left: 70, right: 70),
                    child: Text(
                      appLocalizations.logo,
                      textAlign: TextAlign.center,
                      style: textTheme.headline3,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: SocialLoginButton(
                      onTap: () => _login(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
