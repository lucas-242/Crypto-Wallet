import 'package:crypto_wallet/core/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:crypto_wallet/core/components/shimmer/shimmer.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            currentScreen: state.currentPage.value,
            onChangePage: _onChangePage,
          ),
        ),
      ),
    );
  }

  void _onChangePage(BuildContext context, int index) {
    final cubit = context.read<InitialCubit>();
    cubit.onChangePage(BottomNavigationPage.fromIndex(index));
    context.navigateTo(BottomNavigationPage.getRoute(cubit.state.currentPage));
  }
}
