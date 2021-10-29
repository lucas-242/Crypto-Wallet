import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/modules/home/widgets/coins_slide_widget.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:crypto_wallet/shared/widgets/total_wallet_card/total_wallet_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WalletBloc bloc;
  late final Auth auth;
  late AppLocalizations appLocalizations;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    auth = context.read<Auth>();
    bloc = context.read<WalletBloc>();
    bloc.getCryptos(auth.user!.uid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldKey: _scaffoldKey,
      auth: auth,
      title: appLocalizations.dashboard,
      body: RefreshIndicator(
        onRefresh: () => bloc.getCryptos(auth.user!.uid),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 5),
            child: ValueListenableBuilder<WalletStatus>(
              valueListenable: bloc.statusNotifier,
              builder: (context, status, child) {
                if (status.statusPage == StatusPage.noData) {
                  return Container(
                    height: SizeConfig.height * 0.7,
                    child: Center(
                      child: Text(appLocalizations.noData),
                    ),
                  );
                }

                if (status.statusPage == StatusPage.loading) {
                  return Container(
                    height: SizeConfig.height * 0.7,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalWalletCard(walletData: bloc.walletData),
                    CoinsSlide(walletdData: bloc.walletData),
                    DashboardWatchList(cryptos: bloc.cryptos),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
