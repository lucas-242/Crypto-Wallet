import 'package:crypto_wallet/repositories/trades_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/shared/themes/app_colors.dart';

import 'modules/app/app.dart';
import 'modules/login/login.dart';
import 'modules/splash/splash_page.dart';
import 'modules/insert_trade/insert_trade.dart';
import 'modules/wallet/wallet.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final tradesRepository = TradesRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppBloc()),
        ChangeNotifierProvider(create: (_) => InsertTradeBloc()),
        ChangeNotifierProvider(
            create: (_) => WalletBloc(tradesRepository: tradesRepository)),
      ],
      child: MaterialApp(
        title: 'Crypto Wallet',
        theme: ThemeData(
          primaryColor: AppColors.primary,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashPage(),
          '/app': (context) => App(),
          '/login': (context) => LoginPage(),
          '/insert_trade': (context) => InsertTradePage()
        },
      ),
    );
  }
}
