import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
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
  late final AppLocalizations appLocalizations;

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
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.wallet),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<WalletStatus>(
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
                    child: Center(child: Text('No cryptos in the wallet')),
                  );
                } else {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => bloc.getCryptos(auth.user!.uid),
                      child: ListView.builder(
                          itemCount: bloc.cryptos.length,
                          itemBuilder: (context, index) {
                            return CryptoCard(crypto: bloc.cryptos[index]);
                          }),
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
