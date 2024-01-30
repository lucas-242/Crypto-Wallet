import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _cubit = ServiceLocator.get<AppCubit>();

  @override
  void initState() {
    _cubit.listenUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      bloc: ServiceLocator.get<AppCubit>(),
      listener: (context, state) {
        if (state.user != null) {
          context.globalNavigate(Routes.home);
        } else {
          context.globalNavigate(Routes.login);
        }
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
