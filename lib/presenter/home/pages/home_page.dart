import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/models/wallet.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/presenter/home/components/coins_carrousel.dart';
import 'package:crypto_wallet/presenter/home/components/wallet_total_card.dart';
import 'package:crypto_wallet/presenter/login/cubit/login_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
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
            context.globalNavigate(Routes.login);
          } else if (state.status == BaseStateStatus.error) {
            context.showSnackBar(state.callbackMessage);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return WalletTotalCard(
                    data: const Wallet(
                        totalNow: 10000,
                        totalInvested: 1000,
                        variation: 9000,
                        percentVariation: 100),
                    hideValues: context.read<AppCubit>().state.showWalletValues,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppInsets.md),
              child: CoinsCarrousel(cryptos: [
                WalletCrypto(
                  id: 'aaaa',
                  cryptoId: 'bitcoin',
                  amount: 0.01588,
                  averagePrice: 25752.0,
                  totalInvested: 1000,
                ),
                WalletCrypto(
                  id: 'aaaa',
                  cryptoId: 'ethereum',
                  amount: 0.01588,
                  averagePrice: 25752.0,
                  totalInvested: 1000,
                ),
                WalletCrypto(
                  id: 'aaaa',
                  cryptoId: 'cardano',
                  amount: 0.01588,
                  averagePrice: 25752.0,
                  totalInvested: 1000,
                )
              ]),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _cubit.signOut,
              child: Text(AppLocalizations.current.logout),
            )
          ],
        ),
      ),
    );
  }
}
