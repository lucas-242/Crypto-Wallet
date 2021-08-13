import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/watch_list/watch_list_widget.dart';
import 'package:flutter/material.dart';

class DashboardWatchList extends StatelessWidget {
  final List<CryptoModel> cryptos;
  const DashboardWatchList({Key? key, required this.cryptos}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Container(
        height: SizeConfig.height * 0.3,
        child: DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.stroke,
                tabs: [
                  Tab(text: '24h'),
                  Tab(text: '7d'),
                  Tab(text: '30d'),
                  Tab(text: '1y'),
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
