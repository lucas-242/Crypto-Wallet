import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/presenter/login/cubit/login_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cubit = ServiceLocator.get<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == BaseStateStatus.success) {
            context.navigateTo(Routes.login);
          } else if (state.status == BaseStateStatus.error) {
            context.showSnackBar(state.callbackMessage);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _cubit.signOut,
                  child: Text(AppLocalizations.current.logout),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
