import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/app/app.dart';

class AppMain extends StatefulWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => AppBloc()),
        // ChangeNotifierProvider(create: (_) => CryptosBloc()),
      ],
      child: MaterialApp(
        title: 'Crypto Wallet',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        debugShowCheckedModeBanner: false,
        // home: App()
        initialRoute: '/',
        routes: {
          '/': (context) => App(),
          // '/dashboard':
        },
      ),
    );
  }
}