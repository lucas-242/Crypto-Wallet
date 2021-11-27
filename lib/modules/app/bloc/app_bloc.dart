import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_wallet/shared/core/build_configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends ChangeNotifier {
  List<String> _pages = ['Home', 'Wallet', 'Trades'];

  int _currentPageIndex = 0;
  late String _currentPageName;

  int get currentPageIndex => _currentPageIndex;
  String get currentPageName => _currentPageName;

  bool _showUserTotalOption = false;
  bool get showUserTotalOption => _showUserTotalOption;

  final bottomNavigationKey = GlobalKey();

  AppBloc() {
    _currentPageName = _pages[_currentPageIndex];
    getShowUserTotalOption();
  }

  /// Change between the main app pages
  void changePage(int newPage) {
    _currentPageIndex = newPage;
    _currentPageName = _pages[_currentPageIndex];
    notifyListeners();
  }

  /// Change the app theme
  void changeTheme(AdaptiveThemeManager adaptiveTheme) {
    if (adaptiveTheme.mode == AdaptiveThemeMode.dark) {
      adaptiveTheme.setLight();
    } else {
      adaptiveTheme.setDark();
    }
    notifyListeners();
  }

  /// Change the show total preference
  Future<void> changeShowTotal() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final oldValue = sharedPreferences.getBool(Config.showUserTotalOption);

    if (oldValue != null) {
      await sharedPreferences.setBool(Config.showUserTotalOption, !oldValue);
      _showUserTotalOption = !oldValue;
    } else {
      await sharedPreferences.setBool(Config.showUserTotalOption, false);
      _showUserTotalOption = false;
    }

    notifyListeners();
  }

  void getShowUserTotalOption() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final showUserTotal = sharedPreferences.getBool(Config.showUserTotalOption);
    _showUserTotalOption = showUserTotal ?? false;
  }
}
