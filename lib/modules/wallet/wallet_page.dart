import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/modules/wallet/wallet_status.dart';
import 'package:crypto_wallet/modules/wallet/widgets/trade_tile_widget.dart';
import 'package:crypto_wallet/shared/models/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final auth = FirebaseAuth.instance;
  late final WalletBloc bloc;

  @override
  void initState() {
    bloc = context.read<WalletBloc>();
    if (bloc.trades.isEmpty) bloc.getTrades(auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          onRefresh: () => bloc.getTrades(auth.currentUser!.uid),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: ValueListenableBuilder<WalletStatus>(
              valueListenable: bloc.statusNotifier,
              builder: (context, status, child) {
                if (status.statusPage == StatusPage.loading) {
                  return Container(
                    height: size.height,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (status.statusPage == StatusPage.error) {
                  return Center(child: Text(status.error));
                } else {
                  return Consumer<WalletBloc>(
                    builder: (context, bloc, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          height: size.height,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
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
                                          width: size.width,
                                          child: Text(
                                              DateFormat.yMd().format(date),
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
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          bloc.getTradesByDate(date).length,
                                      itemBuilder: (context, index) {
                                        final trades =
                                            bloc.getTradesByDate(date);
                                        return TradeTile(trade: trades[index]);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
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
