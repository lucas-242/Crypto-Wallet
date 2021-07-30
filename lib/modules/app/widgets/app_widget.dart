import 'package:crypto_wallet/modules/home/home_page.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import 'app_bottom_navigation_widget.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var appBloc = context.watch<AppBloc>();
    SizeConfig().init(context, kBottomNavigationBarHeight);
    return Scaffold(
        body: [
          HomePage(),
          WalletPage(),
          TradesListPage(),
        ][appBloc.currentPageIndex],
        bottomNavigationBar: AppBottomNavigationBar(
          key: appBloc.bottomNavigationKey,
          currentPage: appBloc.currentPageIndex,
          onTap: (index) => appBloc.changePage(index),
        ),
    );
  }
}
