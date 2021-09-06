import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/modules/trades/widgets/trade_tile_list_widget.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/models/dropdown_item_model.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    bloc.loadAd();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.appLocalizations = AppLocalizations.of(context)!;
  }

  @override
  void dispose() {
    bloc.disposeInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: bloc.appLocalizations.trades,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.tradesInsert),
            child: Icon(Icons.add, color: AppColors.primary),
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
                  return RefreshIndicator(
                    onRefresh: () => bloc.getTrades(uid),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        height: SizeConfig.height * 0.7,
                        child: Center(child: Text(status.error)),
                      ),
                    ),
                  );
                } else if (status.statusPage == StatusPage.noData) {
                  return Container(
                    height: SizeConfig.height * 0.7,
                    child: Center(child: Text(bloc.appLocalizations.noTrades)),
                  );
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        DropdownSearch<DropdownItem>(
                          label: bloc.appLocalizations.filter,
                          selectedItem: bloc.filterSelected,
                          mode: Mode.MENU,
                          maxHeight: SizeConfig.height * 0.22,
                          items: bloc.cryptoList,
                          itemAsString: (DropdownItem u) => u.text,
                          onChanged: (DropdownItem? item) => bloc.onFilter(item),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Consumer<TradesBloc>(
                              builder: (context, bloc, child) {
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
                                bloc
                                    .deleteTrade(
                                      trade: trade,
                                      uid: uid,
                                      walletBloc: walletBloc,
                                    )
                                    .then((value) => bloc.loadAd());
                              },
                            );
                          }),
                        ),
                      ],
                    ),
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
