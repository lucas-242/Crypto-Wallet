import 'package:crypto_wallet/core/components/shimmer/shimmer.dart';
import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/domain/models/enums/bottom_navigation_page.dart';
import 'package:crypto_wallet/presenter/app/components/custom_bottom_navigation.dart';
import 'package:crypto_wallet/presenter/app/components/custom_drawer.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/presenter/login/cubit/login_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
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
  final _appCubit = ServiceLocator.get<AppCubit>();
  final _loginCubit = ServiceLocator.get<LoginCubit>();
  final _key = GlobalKey<NavigatorState>(debugLabel: 'Shell Key');

  String get title => widget.route.capitalize();

  @override
  void initState() {
    Routes.shellKey = _key;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _appCubit),
        BlocProvider(create: (context) => _loginCubit),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          drawer: Drawer(
            child: CustomDrawer(
              onPressedLogout: _loginCubit.signOut,
              onPressedShowTotal: _appCubit.changeShowWalletValues,
              user: _appCubit.state.user!,
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              _appCubit.state.currentPage.name.capitalize(),
              style: context.textSubtitleLg.copyWith(color: AppColors.primary),
            ),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: context.showDrawer,
            ),
          ),
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
              bloc: _appCubit,
              builder: (context, state) => CustomBottomNavigation(
                currentScreen: _appCubit.state.currentPageValue,
                onChangePage: (page) => _onChangePage(context, page),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onChangePage(BuildContext context, int index) {
    _appCubit.changePage(index);
    context
        .navigateTo(BottomNavigationPage.getRoute(_appCubit.state.currentPage));
  }
}
