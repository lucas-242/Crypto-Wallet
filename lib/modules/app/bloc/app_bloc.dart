import 'package:crypto_wallet/shared/themes/app_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ThemeType { Light, Dark }

class AppBloc extends ChangeNotifier {
  List<String> _pages = ['Home', 'Wallet', 'Trades'];

  int _currentPageIndex = 0;
  late String _currentPageName;

  int get currentPageIndex => _currentPageIndex;
  String get currentPageName => _currentPageName;

  ThemeData _currentTheme = AppThemes.lightTheme;
  ThemeType _themeType = ThemeType.Light;

  ThemeData get currentTheme => _currentTheme;

  final bottomNavigationKey = GlobalKey();

  AppBloc() {
    _currentPageName = _pages[_currentPageIndex];
  }

  /// Change between the main app pages
  void changePage(int newPage) {
    _currentPageIndex = newPage;
    _currentPageName = _pages[_currentPageIndex];
    notifyListeners();
  }

  /// Change the app theme
  void toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      _currentTheme = AppThemes.lightTheme;
      _themeType = ThemeType.Light;
    } else {
      _currentTheme = AppThemes.darkTheme;
      _themeType = ThemeType.Dark;
    }
    notifyListeners();
  }
}
