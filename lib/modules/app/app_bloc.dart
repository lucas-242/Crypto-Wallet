import 'package:flutter/cupertino.dart';

class AppBloc extends ChangeNotifier {
  List<String> _pages = ['Home', 'Wallet'];

  int _currentPageIndex = 0;
  late String _currentPageName;

  int get currentPageIndex => _currentPageIndex;
  String get currentPageName => _currentPageName;

  AppBloc() {
    _currentPageName = _pages[_currentPageIndex];
  }

  void changePage(int newPage) {
    _currentPageIndex = newPage;
    _currentPageName = _pages[_currentPageIndex];
    notifyListeners();
  }
}
