import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/modules/wallet/bloc/wallet_status.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/modules/wallet/bloc/wallet_bloc.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final auth = FirebaseAuth.instance;
  //TODO: Create a single bloc to manipulate the cryptos
  late final WalletBloc bloc;
  late final HomeBloc homeBloc;

  @override
  void initState() {
    bloc = context.read<WalletBloc>();
    homeBloc = context.read<HomeBloc>();
    if (homeBloc.cryptos.isEmpty) homeBloc.getDashboardData(auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Wallet'),
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
                      onRefresh: () =>
                          homeBloc.getDashboardData(auth.currentUser!.uid),
                      child: ListView.builder(
                          itemCount: homeBloc.cryptos.length,
                          itemBuilder: (context, index) {
                            return CryptoCard(crypto: homeBloc.cryptos[index]);
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
