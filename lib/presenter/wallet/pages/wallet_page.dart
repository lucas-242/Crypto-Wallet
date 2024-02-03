import 'package:crypto_wallet/core/components/status_pages/status_pages.dart';
import 'package:crypto_wallet/core/components/walelt_total_card/wallet_total_card.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/presenter/wallet/components/wallet_crypto_card.dart';
import 'package:crypto_wallet/presenter/wallet/cubit/wallet_cubit.dart';
import 'package:crypto_wallet/themes/settings/app_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WalletCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.md,
      ),
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) => state.when(
          onState: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletTotalCard(wallet: state.wallet, showTotalInvested: true),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: cubit.getWalletData,
                  child: ListView.builder(
                    itemCount: state.wallet.cryptos.length,
                    itemBuilder: (context, index) {
                      final crypto = state.wallet.cryptos[index];
                      final isNextOpen = state.wallet.cryptos
                              .elementAtOrNull(index + 1)
                              ?.isOpen ??
                          false;

                      return WalletCryptoCard(
                        crypto: crypto,
                        isNextCardOpen: isNextOpen,
                        onTap: (crypto) =>
                            cubit.onOpenCloseCryptoCard(crypto.cryptoId),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          onLoading: () => const LoadingPage(),
          onError: (_) => const FeedbackPage(message: 'Error'),
          onNoData: () =>
              FeedbackPage(message: AppLocalizations.current.noCryptos),
        ),
      ),
    );
  }
}
