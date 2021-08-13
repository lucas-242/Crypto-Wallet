import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/modules/home/widgets/coins_slide_widget.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/constants/routes.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WalletBloc bloc;
  late final Auth auth;

  @override
  void initState() {
    auth = context.read<Auth>();
    bloc = context.read<WalletBloc>();
    bloc.getCryptos(auth.user!.uid);
    super.initState();
  }

  void _logout() {
    auth.signOut().then((value) {
      if (value) {
        bloc.eraseData();
        context.read<TradesBloc>().eraseData();
        context.read<WalletBloc>().eraseData();
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        getAppSnackBar(
            message: 'Error trying to logout',
            type: SnackBarType.error,
            onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
        actions: [
          IconButton(
            onPressed: () => _logout(),
            icon: Icon(Icons.logout),
            iconSize: 20,
            color: AppColors.primary,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => bloc.getCryptos(auth.user!.uid),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25),
            child: ValueListenableBuilder<WalletStatus>(
              valueListenable: bloc.statusNotifier,
              builder: (context, status, child) {
                if (status.statusPage == StatusPage.noData) {
                  return Container(
                    height: SizeConfig.height * 0.7,
                    child: Center(
                      child: Text('There is no data on your wallet yet'),
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
                    TotalWalletCard(dashboardData: bloc.dashboardData),
                    CoinsSlide(dashboardData: bloc.dashboardData),
                    // DonutChart(
                    //   data: bloc.dashboardData.cryptosSummary
                    //       .asMap()
                    //       .entries
                    //       .map((e) => DonutChartModel(
                    //           percent: e.value.percent,
                    //           color: bloc.chartColors[e.key]))
                    //       .toList(),
                    // ),
                    // Chart(bloc: bloc),
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
