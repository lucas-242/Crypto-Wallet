import 'package:crypto_wallet/core/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:crypto_wallet/core/components/shimmer/shimmer.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.route});

  static State<AppShell> of(BuildContext context) {
    return context.findAncestorStateOfType<_AppShellState>()!;
  }

  final String route;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _bloc = ServiceLocator.get<AppCubit>();
  final _key = GlobalKey<NavigatorState>(debugLabel: 'Shell Key');

  @override
  void initState() {
    Routes.shellKey = _key;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _bloc),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: SafeArea(
            child: Shimmer(
              child: Navigator(
                key: _key,
                initialRoute: widget.route,
                onGenerateRoute: Routes.onGenerateAppShellRoute,
              ),
            ),
          ),
          extendBody: true,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Shimmer(
            child: BlocBuilder(
              bloc: _bloc,
              builder: (context, state) => CustomBottomNavigation(
                currentScreen: _bloc.state.currentPageValue,
                onChangePage: (page) => _onChangePage(context, page),
              ),
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
