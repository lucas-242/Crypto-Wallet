import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/shared/models/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TradesPage extends StatefulWidget {
  const TradesPage({Key? key}) : super(key: key);

  @override
  _TradesPageState createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  late final TradesBloc bloc;

  @override
  void initState() {
    bloc = context.read<TradesBloc>();
    if (bloc.trades.isEmpty) bloc.getTrades(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trades'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/insert_trade'),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ]
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<TradesStatus>(
              valueListenable: bloc.statusNotifier,
              builder: (context, status, child) {
                if (status.statusPage == StatusPage.loading) {
                  return Container(
                    height: SizeConfig.height * 0.7,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (status.statusPage == StatusPage.error) {
                  return Container(
                    height: SizeConfig.height * 0.7,
                    child: Center(child: Text(status.error)),
                  );
                } else if (status.statusPage == StatusPage.noData) {
                  return Container(
                    height: SizeConfig.height * 0.7,
                    child: Center(child: Text('No trades in the wallet')),
                  );
                } else {
                  return _tradeList();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tradeList() {
    return Expanded(
      child: Consumer<TradesBloc>(
        builder: (context, bloc, child) {
          print(SizeConfig.bottomNavigation);
          return RefreshIndicator(
            onRefresh: () => bloc.getTrades(uid),
            child: ListView.builder(
              itemCount: bloc.dates.length,
              itemBuilder: (context, dateIndex) {
                final date = bloc.dates[dateIndex];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Container(
                            width: SizeConfig.width,
                            child: Text(DateFormat.yMd().format(date),
                                textAlign: TextAlign.left,
                                style: AppTextStyles.captionBoldBody),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                    Container(
                      height: 75 * bloc.getTradesByDate(date).length.toDouble(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bloc.getTradesByDate(date).length,
                        itemBuilder: (context, index) {
                          final trades = bloc.getTradesByDate(date);
                          return TradeTile(
                            trade: trades[index],
                            onDelete: () {
                              final walletBloc = context.read<WalletBloc>();
                              bloc.deleteTrade(
                                  trade: trades[index],
                                  uid: uid,
                                  walletBloc: walletBloc);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
