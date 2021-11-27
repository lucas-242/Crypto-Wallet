import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/app/app.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:crypto_wallet/shared/widgets/total_wallet_card/total_wallet_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late final Auth auth;
  late final WalletBloc bloc;
  late AppLocalizations appLocalizations;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    bloc = context.read<WalletBloc>();
    auth = context.read<Auth>();
    if (bloc.cryptos.isEmpty) bloc.getCryptos(auth.user!.uid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: appLocalizations.wallet,
      scaffoldKey: _scaffoldKey,
      auth: auth,
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 5),
        child: ValueListenableBuilder<WalletStatus>(
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
                child: Center(child: Text(appLocalizations.noCryptos)),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<AppBloc>(
                    builder: (context, appBloc, child) {
                      return TotalWalletCard(
                        walletData: bloc.walletData,
                        showTotalInvested: true,
                        showUserTotal: appBloc.showUserTotalOption,
                      );
                    },
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => bloc.getCryptos(auth.user!.uid),
                      child: ListView.builder(
                        itemCount: bloc.cryptos.length,
                        itemBuilder: (context, index) {
                          return CryptoCard(
                            crypto: bloc.cryptos[index],
                            openedIndex: bloc.openedIndex,
                            index: index,
                            onTap: (int? tappedIndex) =>
                                setState(() => bloc.openedIndex = tappedIndex),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
