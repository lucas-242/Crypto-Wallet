import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/app/app.dart';
import 'modules/insert_trade/insert_trade.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppBloc()),
        ChangeNotifierProvider(create: (_) => InsertTradeBloc()),
      ],
      child: MaterialApp(
        title: 'Crypto Wallet',
        theme: ThemeData(
          primaryColor: AppColors.primary,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/app',
        routes: {
          '/app': (context) => App(),
          '/insert_trade': (context) => InsertTradePage()
          // '/dashboard':
        },
      ),
    );
  }
}