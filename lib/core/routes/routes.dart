import 'package:flutter/material.dart';

export 'routes_extensions.dart';

abstract class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/';
  static const wallet = '/wallet';
  static const trades = '/trades';
  static const addTrade = '$trades/add';

  static final globalKey = GlobalKey<NavigatorState>(debugLabel: 'Global Key');
  static final shellKey = GlobalKey<NavigatorState>(debugLabel: 'Shell Key');
}
