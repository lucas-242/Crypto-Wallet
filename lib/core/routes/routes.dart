export 'routes_extensions.dart';

///Represents the entire routes to navigate in the app
class Routes {
  static const app = '/';
  static const login = '/login';
  static const home = '/home';
  static const wallet = '/wallet';
  static const trades = '/trades';
  static const addTrade = '$trades/add';
}

///Represents the routes with relative paths
///
///It should be used only in the routes_config.dart to easy the configuration
class RelativePaths {
  static const app = '/';
  static const login = '/login';
  static const home = '/home';
  static const wallet = '/wallet';
  static const trades = '/trades';

  static const addTrade = 'add';
}
