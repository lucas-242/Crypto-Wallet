import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/watch_list/watch_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardWatchList extends StatelessWidget {
  final List<CryptoModel> cryptos;
  const DashboardWatchList({Key? key, required this.cryptos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Container(
        height: SizeConfig.height * 0.33,
        child: DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor:
                    AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                        ? AppColors.white
                        : AppColors.text,
                tabs: [
                  Tab(text: '24h'),
                  Tab(text: '7d'),
                  Tab(text: '30d'),
                  Tab(text: appLocalizations.oneYear),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: WatchList(
                        cryptos: cryptos,
                        time: WatchListTime.priceChangePercentage24hInCurrency,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: WatchList(
                        cryptos: cryptos,
                        time: WatchListTime.priceChangePercentage7dInCurrency,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: WatchList(
                        cryptos: cryptos,
                        time: WatchListTime.priceChangePercentage30dInCurrency,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: WatchList(
                        cryptos: cryptos,
                        time: WatchListTime.priceChangePercentage1yInCurrency,
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
