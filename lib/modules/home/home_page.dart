import 'package:crypto_wallet/modules/home/home.dart';
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
  late final String uid;

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
      ),
      body: RefreshIndicator(
        onRefresh: () => bloc.getDashboardData(uid),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //TODO: Show feedback to user when doesn't have data
              children: [
                TotalWalletCard(bloc: bloc),
                Chart(bloc: bloc),
                DashboardWatchList(bloc: bloc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
