import 'package:crypto_wallet/themes/settings/app_insets.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppInsets.xLg,
        right: AppInsets.xLg,
        bottom: AppInsets.xxxSm,
      ),
      child: ValueListenableBuilder<WalletStatus>(
        valueListenable: bloc.statusNotifier,
        builder: (context, status, child) {
          if (status.statusPage == StatusPage.loading) {
            return SizedBox(
              height: SizeConfig.height * 0.7,
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (status.statusPage == StatusPage.error) {
            return SizedBox(
              height: SizeConfig.height * 0.7,
              child: Center(child: Text(status.error)),
            );
          } else if (status.statusPage == StatusPage.noData) {
            return SizedBox(
              height: SizeConfig.height * 0.7,
              child: Center(child: Text(appLocalizations.noCryptos)),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<AppBloc>(
                  builder: (context, appBloc, child) {
                    return TotalWalletCard(
                      walletData: bloc.walletData,
                      showTotalInvested: true,
                      showUserTotal: appBloc.showUserTotalOption,
                    );
                  },
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => bloc.getCryptos(auth.user!.uid),
                    child: ListView.builder(
                      itemCount: bloc.cryptosWithAds.length,
                      itemBuilder: (context, index) {
                        if (bloc.cryptosWithAds[index] is BannerAd) {
                          return AdCard(
                            openedIndex: bloc.openedIndex,
                            index: index,
                            ad: bloc.cryptosWithAds[index],
                          );
                        }
                        return CryptoCard(
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
        },
      ),
    );
  }
}
