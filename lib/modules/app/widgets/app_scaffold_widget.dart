import 'package:crypto_wallet/modules/home/pages/home_page.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import 'app_bottom_navigation_widget.dart';

/// Widget that is the scaffold of the main pages - Home, Wallet and Trades
class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    var appBloc = context.watch<AppBloc>();
    SizeConfig(context, kBottomNavigationBarHeight);
    return Scaffold(
        body: [
          HomePage(),
          WalletPage(),
          TradesListPage(),
        ][appBloc.currentPageIndex],
        bottomNavigationBar: AppBottomNavigationBar(
          key: appBloc.bottomNavigationKey,
          currentPage: appBloc.currentPageIndex,
          onTap: (index) => appBloc.changePage(index)
        ),
    );
  }
}
