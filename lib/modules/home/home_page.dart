import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;
  late String uid;

  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    uid = auth.currentUser!.uid;
    bloc = context.read<HomeBloc>();
    if (bloc.cryptos.isEmpty) bloc.getDashboardData(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: Fix signOut - Erase all data from the app
              bloc.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => bloc.getDashboardData(uid),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25),
            child: ValueListenableBuilder<HomeStatus>(
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalWalletCard(bloc: bloc),
                    Chart(bloc: bloc),
                    DashboardWatchList(bloc: bloc),
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
