import 'package:crypto_wallet/app_store.dart';
import 'package:crypto_wallet/core/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:crypto_wallet/core/components/shimmer/shimmer.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:flutter/material.dart';

final appStore = AppStore();

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Shimmer(child: child),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Shimmer(
          child: CustomBottomNavigation(
            currentScreen: appStore.currentPageValue,
            onChangePage: (page) => _onChangePage(context, page),
          ),
        ),
      ),
    );
  }

  void _onChangePage(BuildContext context, int index) {
    appStore.changePage(index);
    context.navigateTo(BottomNavigationPage.getRoute(appStore.currentPage));
  }
}
