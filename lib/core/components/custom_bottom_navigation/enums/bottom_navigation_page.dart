import 'package:crypto_wallet/core/routes/routes.dart';

enum BottomNavigationPage {
  home(0),
  wallet(1),
  trades(2);

  const BottomNavigationPage(this.value);

  final int value;

  static BottomNavigationPage fromIndex(int value) {
    for (BottomNavigationPage page in BottomNavigationPage.values) {
      if (page.value == value) {
        return page;
      }
    }

    return home;
  }

  static String getRoute(BottomNavigationPage page) {
    String route;
    switch (page) {
      case BottomNavigationPage.home:
        route = Routes.home;
      case BottomNavigationPage.wallet:
        route = Routes.wallet;
      case BottomNavigationPage.trades:
        route = Routes.trades;
      default:
        route = Routes.home;
    }

    route += Routes.app;

    return route;
  }
}
