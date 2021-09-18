import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBloc extends ChangeNotifier {
  List<String> _pages = ['Home', 'Wallet', 'Trades'];

  int _currentPageIndex = 0;
  late String _currentPageName;

  int get currentPageIndex => _currentPageIndex;
  String get currentPageName => _currentPageName;

  final bottomNavigationKey = GlobalKey();

  AppBloc() {
    _currentPageName = _pages[_currentPageIndex];
  }

  setInitialTheme(AdaptiveThemeMode themeMode) {
    // _currentTheme = themeData;
    // if (themeData == AppThemes.lightTheme)
    //   _themeType = ThemeType.Light;
    // else if (themeData == AppThemes.darkTheme) _themeType = ThemeType.Dark;
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
}
