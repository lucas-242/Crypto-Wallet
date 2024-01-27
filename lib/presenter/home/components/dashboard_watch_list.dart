import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/presenter/home/components/watch_list.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class DashboardWatchList extends StatelessWidget {
  const DashboardWatchList({Key? key, required this.cryptos}) : super(key: key);
  final List<WalletCrypto> cryptos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppInsets.lg),
      child: SizedBox(
        height: context.height * 0.33,
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.text,
                tabs: [
                  const Tab(text: '24h'),
                  const Tab(text: '7d'),
                  const Tab(text: '30d'),
                  Tab(text: AppLocalizations.current.oneYear),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: AppInsets.sm),
                      child: WatchList(cryptos: cryptos),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppInsets.sm),
                      child: WatchList(
                        cryptos: cryptos,
                        time: WatchListTime.percentage7d,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppInsets.sm),
                      child: WatchList(
                        cryptos: cryptos,
                        time: WatchListTime.percentage30d,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppInsets.sm),
                      child: WatchList(
                        cryptos: cryptos,
                        time: WatchListTime.percentage1y,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
