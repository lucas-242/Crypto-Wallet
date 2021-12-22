import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/core/routes.dart';
import 'package:crypto_wallet/shared/models/dropdown_item_model.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:crypto_wallet/shared/widgets/custom_dropdown/custom_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TradesListPage extends StatefulWidget {
  const TradesListPage({Key? key}) : super(key: key);

  @override
  _TradesListPageState createState() => _TradesListPageState();
}

class _TradesListPageState extends State<TradesListPage> {
  late final Auth auth;
  late final TradesBloc bloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    auth = context.read<Auth>();
    bloc = context.read<TradesBloc>();
    if (bloc.trades.isEmpty) bloc.getTrades(auth.user!.uid);
    bloc.loadInterstitialAd();
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
    return CustomScaffold(
      title: bloc.appLocalizations.trades,
      scaffoldKey: _scaffoldKey,
      auth: auth,
      appBarActions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.tradesInsert),
          child: Icon(Icons.add, color: AppColors.primary),
        ),
      ],
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
                    onRefresh: () => bloc.getTrades(auth.user!.uid),
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
                        CustomDropdown(
                          label: bloc.appLocalizations.filter,
                          hint: bloc.appLocalizations.hintFieldCrypto,
                          items: bloc.cryptoList,
                          selectedItem: bloc.filterSelected,
                          onChanged: (DropdownItem? item) =>
                              bloc.onFilter(item),
                          showSeach: true,
                          searchHint: 'BTC, ETH, ADA ...',
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Consumer<TradesBloc>(
                              builder: (context, bloc, child) {
                            return TradeTileList(
                              bloc: bloc,
                              onTap: (trade) => Navigator.pushNamed(
                                context,
                                AppRoutes.tradesDetails,
                                arguments: {
                                  'trade': trade,
                                  'uid': auth.user!.uid
                                },
                              ),
                              onRefresh: () => bloc.getTrades(auth.user!.uid),
                              onDelete: (trade) {
                                final walletBloc = context.read<WalletBloc>();
                                bloc
                                    .onDelete(
                                      trade: trade,
                                      uid: auth.user!.uid,
                                      walletBloc: walletBloc,
                                    )
                                    .then((value) => bloc.loadInterstitialAd());
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
