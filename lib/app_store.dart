import 'package:crypto_wallet/core/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore extends _AppStore with _$AppStore {}

abstract class _AppStore with Store {
  @observable
  int currentPageValue = 0;

  @observable
  BottomNavigationPage currentPage = BottomNavigationPage.home;

  @action
  void changePage(int newPage) {
    currentPageValue = newPage;
    currentPage = BottomNavigationPage.fromIndex(newPage);
  }
}
