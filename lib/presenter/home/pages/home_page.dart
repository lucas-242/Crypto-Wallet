import 'package:crypto_wallet/core/components/status_pages/status_pages.dart';
import 'package:crypto_wallet/core/components/walelt_total_card/wallet_total_card.dart';
import 'package:crypto_wallet/presenter/home/components/cryptos_carrousel.dart';
import 'package:crypto_wallet/presenter/home/components/watch_list_tab.dart';
import 'package:crypto_wallet/presenter/wallet/cubit/wallet_cubit.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<WalletCubit>().getWalletData,
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) => state.when(
          onState: (_) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
                child: WalletTotalCard(wallet: state.wallet),
              ),
              CryptosCarrousel(cryptos: state.wallet.cryptos),
              Expanded(child: WatchListTab(cryptos: state.wallet.cryptos)),
            ],
          ),
          onError: (_) => FeedbackPage(message: state.callbackMessage),
          onLoading: () => const LoadingPage(),
        ),
      ),
    );
  }
}
