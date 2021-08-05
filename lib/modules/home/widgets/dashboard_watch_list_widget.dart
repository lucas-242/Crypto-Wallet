import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/watch_list/watch_list_widget.dart';
import 'package:flutter/material.dart';

class DashboardWatchList extends StatefulWidget {
  final HomeBloc bloc;
  const DashboardWatchList({Key? key, required this.bloc}) : super(key: key);

  @override
  _DashboardWatchListState createState() => _DashboardWatchListState();
}

class _DashboardWatchListState extends State<DashboardWatchList> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: ValueListenableBuilder<HomeStatus>(
                valueListenable: widget.bloc.statusNotifier,
                builder: (context, status, child) {
                  if (status.statusPage == StatusPage.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: widget.bloc.cryptos,
                          time:
                              WatchListTime.priceChangePercentage24hInCurrency,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: widget.bloc.cryptos,
                          time: WatchListTime.priceChangePercentage7dInCurrency,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: widget.bloc.cryptos,
                          time:
                              WatchListTime.priceChangePercentage30dInCurrency,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: widget.bloc.cryptos,
                          time: WatchListTime.priceChangePercentage1yInCurrency,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}