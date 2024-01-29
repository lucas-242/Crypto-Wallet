import 'package:crypto_wallet/core/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:crypto_wallet/core/components/shimmer/shimmer.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _bloc = ServiceLocator.get<AppCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Shimmer(child: widget.child),
          extendBody: true,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Shimmer(
            child: CustomBottomNavigation(
              currentScreen: _bloc.state.currentPageValue,
              onChangePage: (page) => _onChangePage(context, page),
            ),
          ),
        ),
      ),
    );
  }

  void _onChangePage(BuildContext context, int index) {
    _bloc.changePage(index);
    context.navigateTo(BottomNavigationPage.getRoute(_bloc.state.currentPage));
  }
}
