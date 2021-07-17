import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/social_login_button/social_login_button_widget.dart';
import 'package:flutter/material.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size size;
  final loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.3),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Crypto',
                      style: AppTextStyles.titleHome
                          .copyWith(color: AppColors.primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Wallet',
                      style: AppTextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100, left: 70, right: 70),
                    child: Text(
                      'See all your cryptos in an unique place',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleBoldGrey,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   width: size.width,
            //   height: size.height * 0.36,
            //   color: AppColors.primary,
            // ),
            _googleButton(),
          ],
        ),
      ),
    );
  }

  Widget _googleButton() {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 40),
            child: SocialLoginButton(
              onTap: () {
                loginBloc.signInWithGoogle().then((value) {
                  if (value) Navigator.of(context).pushReplacementNamed('/app');
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: AppColors.red,
                    content: Text('Error trying to login'),
                  ));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
