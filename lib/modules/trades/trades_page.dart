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
    final size = MediaQuery.of(context).size;
//TODO: Fix Error
//E/flutter (25758): [ERROR:flutter/lib/ui/ui_dart_state.cc(199)] Unhandled Exception: This widget has been unmounted, so the State no longer has a context (and should be considered defunct).
//E/flutter (25758): Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          onRefresh: () => bloc.getTrades(uid),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Trades', style: AppTextStyles.titleBoldGrey),
                    SizedBox(height: 25),
                    ValueListenableBuilder<TradesStatus>(
                      valueListenable: bloc.statusNotifier,
                      builder: (context, status, child) {
                        if (status.statusPage == StatusPage.loading) {
                          return Container(
                            height: size.height * 0.7,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (status.statusPage == StatusPage.error) {
                          return Container(
                            height: size.height * 0.7,
                            child: Center(child: Text(status.error)),
                          );
                        } else if (status.statusPage == StatusPage.noData) {
                          return Container(
                            height: size.height * 0.7,
                            child:
                                Center(child: Text('No trades in the wallet')),
                          );
                        } else {
                          return Consumer<TradesBloc>(
                            builder: (context, bloc, child) {
                              return Container(
                                height: size.height,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: bloc.dates.length,
                                  itemBuilder: (context, dateIndex) {
                                    final date = bloc.dates[dateIndex];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: size.width,
                                                child: Text(
                                                    DateFormat.yMd()
                                                        .format(date),
                                                    textAlign: TextAlign.left,
                                                    style: AppTextStyles
                                                        .captionBoldBody),
                                              ),
                                              Divider(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 75 *
                                              bloc
                                                  .getTradesByDate(date)
                                                  .length
                                                  .toDouble(),
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: bloc
                                                .getTradesByDate(date)
                                                .length,
                                            itemBuilder: (context, index) {
                                              final trades =
                                                  bloc.getTradesByDate(date);
                                              return TradeTile(
                                                trade: trades[index],
                                                onDelete: () {
                                                  final walletBloc = context
                                                      .read<WalletBloc>();
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
                          );
                        }
                      },
                    ),
                  ]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/insert_trade'),
          child: Icon(Icons.add),
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }
}
