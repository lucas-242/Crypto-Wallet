import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/presenter/login/cubit/login_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _cubit = ServiceLocator.get<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Builder(builder: (context) {
        return BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == BaseStateStatus.success) {
              context.globalNavigate(Routes.home);
            } else if (state.status == BaseStateStatus.error) {
              context.showSnackBar(state.callbackMessage);
            }
          },
          child: Scaffold(
            body: Column(
              children: [
                const Spacer(),
                Center(
                  child: Text(
                    'Crypto',
                    style: context.textTitleXXLg
                        .copyWith(color: AppColors.primary),
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
                  onPressed: _cubit.signInWithGoogle,
                  child: const Text('Google'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
