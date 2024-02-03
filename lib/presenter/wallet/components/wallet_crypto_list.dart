import 'package:crypto_wallet/core/components/walelt_total_card/wallet_total_card.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/presenter/wallet/components/wallet_crypto_card.dart';
import 'package:crypto_wallet/presenter/wallet/cubit/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCryptoList extends StatelessWidget {
  const WalletCryptoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return WalletTotalCard(
              data: state.wallet,
              showTotalInvested: true,
              //TODO: Get it from store
              // hideValues: state.showWalletValues,
            );
          },
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => bloc.getCryptos(auth.user!.uid),
            child: ListView.builder(
              itemCount: bloc.cryptosWithAds.length,
              itemBuilder: (context, index) {
                // if (bloc.cryptosWithAds[index] is BannerAd) {
                //   return AdCard(
                //     openedIndex: bloc.openedIndex,
                //     index: index,
                //     ad: bloc.cryptosWithAds[index],
                //   );
                // }
                return WalletCryptoCard(
                  crypto: bloc.cryptosWithAds[index],
                  openedIndex: bloc.openedIndex,
                  index: index,
                  onTap: (int? tappedIndex) =>
                      setState(() => bloc.openedIndex = tappedIndex),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
