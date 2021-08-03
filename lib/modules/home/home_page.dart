import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/modules/home/widgets/indicator_widget.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/donut_chart/donut_chart.dart';
import 'package:crypto_wallet/shared/widgets/watch_list/watch_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;
  late final String uid;

  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    uid = auth.currentUser!.uid;
    bloc = context.read<HomeBloc>();
    if (bloc.cryptos.isEmpty) bloc.getDashboardData(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () => bloc.getDashboardData(uid),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //TODO: Remove these widgets from functions
              //TODO: Show feedback to user when doesn't have data
              children: [
                _totalCard(),
                _chart(),
                _variations(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _totalCard() {
    return Card(
      color: AppColors.shape,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: ValueListenableBuilder<HomeStatus>(
            valueListenable: bloc.statusNotifier,
            builder: (context, status, widget) {
              if (status.statusPage == StatusPage.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: AppTextStyles.titleRegular,
                  ),
                  SizedBox(height: 15),
                  Text(
                    NumberFormat.currency(symbol: '\$')
                        .format(bloc.dashboardData.total),
                    style: AppTextStyles.titleHome,
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        '${bloc.dashboardData.variation.isNegative ? '' : '+'} ${NumberFormat.currency(symbol: '\$').format(bloc.dashboardData.variation)} (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(bloc.dashboardData.percentVariation / 100)})',
                        style: AppTextStyles.titleRegular,
                      ),
                      Icon(
                          bloc.dashboardData.variation.isNegative
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: bloc.dashboardData.variation.isNegative
                              ? AppColors.red
                              : AppColors.secondary),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget _chart() {
    return ValueListenableBuilder<HomeStatus>(
      valueListenable: bloc.statusNotifier,
      builder: (context, status, widget) {
        if (status.statusPage == StatusPage.success) {
          return Row(
            children: [
              DonutChart(
                data: bloc.dashboardData.cryptosSummary
                    .asMap()
                    .entries
                    .map((e) => DonutChartModel(
                        percent: e.value.percent,
                        color: bloc.chartColors[e.key]))
                    .toList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        bloc.dashboardData.cryptosSummary.asMap().entries.map(
                      (e) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Indicator(
                            color: bloc.chartColors[e.key],
                            text:
                                '${e.value.crypto} (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(e.value.percent / 100)})',
                            subtext: e.value.amount.toStringAsFixed(8),
                          ),
                        );
                      },
                    ).toList()),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _variations() {
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
                valueListenable: bloc.statusNotifier,
                builder: (context, status, widget) {
                  if (status.statusPage == StatusPage.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: bloc.cryptos,
                          time:
                              WatchListTime.priceChangePercentage24hInCurrency,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: bloc.cryptos,
                          time: WatchListTime.priceChangePercentage7dInCurrency,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: bloc.cryptos,
                          time:
                              WatchListTime.priceChangePercentage30dInCurrency,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WatchList(
                          cryptos: bloc.cryptos,
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
