import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/presenter/home/components/watch_list.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key, required this.cryptos});
  final List<WalletCrypto> cryptos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppInsets.lg,
        left: AppInsets.md,
        right: AppInsets.md,
      ),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.text,
              labelStyle: context.textSubtitleMd,
              indicatorSize: TabBarIndicatorSize.tab,
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
                  WatchList(cryptos: cryptos),
                  WatchList(
                    cryptos: cryptos,
                    time: WatchListTime.percentage7d,
                  ),
                  WatchList(
                    cryptos: cryptos,
                    time: WatchListTime.percentage30d,
                  ),
                  WatchList(
                    cryptos: cryptos,
                    time: WatchListTime.percentage1y,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
