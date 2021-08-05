import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/modules/trades/widgets/trade_tile_list_widget.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradesListPage extends StatefulWidget {
  const TradesListPage({Key? key}) : super(key: key);

  @override
  _TradesListPageState createState() => _TradesListPageState();
}

class _TradesListPageState extends State<TradesListPage> {
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
        title: Text('Trades'),
        brightness: Brightness.dark,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.tradesInsert),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ],
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
                  return Expanded(
                    child:
                        Consumer<TradesBloc>(builder: (context, bloc, child) {
                      return TradeTileList(
                        bloc: bloc,
                        onTap: (trade) => Navigator.pushNamed(
                          context,
                          AppRoutes.tradesDetails,
                          arguments: {'trade': trade, 'uid': uid},
                        ),
                        onRefresh: () => bloc.getTrades(uid),
                        onDelete: (trade) {
                          final walletBloc = context.read<WalletBloc>();
                          bloc.deleteTrade(
                            trade: trade,
                            uid: uid,
                            walletBloc: walletBloc,
                          );
                        },
                      );
                    }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
