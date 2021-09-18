import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'blocs/wallet/wallet.dart';
import 'modules/app/app.dart';
import 'modules/trades/trades.dart';
import 'repositories/coin_repository/coin_repository.dart';
import 'repositories/wallet_repository/wallet_repository.dart';
import 'shared/auth/auth.dart';
import 'shared/helpers/crypto_helper.dart';

class MainApp extends StatefulWidget {
  MainApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final walletRepository = WalletRepository();
  final coinRepository = CoinRepository();

  @override
  void initState() {
    coinRepository.getAppCoins().then((value) {
      CryptoHelper.setCoinsList(marketcapData: value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Auth()),
      ChangeNotifierProvider(create: (_) => AppBloc()),
      ChangeNotifierProvider(
          create: (_) => TradesBloc(walletRepository: walletRepository)),
      ChangeNotifierProvider(
        create: (_) => WalletBloc(
          walletRepository: walletRepository,
          coinRepository: coinRepository,
        ),
      ),
    ], child: App(walletRepository: walletRepository));
  }
}
