import 'package:crypto_wallet/app_store.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _store = ServiceLocator.get<AppStore>();

  @override
  void initState() {
    _store.listenUser();
    super.initState();
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactionBuilder(
      builder: (context) {
        return reaction((_) => _store.userStream.status == StreamStatus.active,
            (value) {
          if (_store.userStream.value != null) {
            context.navigateTo(Routes.home);
          } else {
            context.navigateTo(Routes.login);
          }
        }, delay: 3000);
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Crypto',
                style: context.textTitleXLg.copyWith(color: AppColors.primary),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'Wallet',
                style: context.textTitleXLg,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
