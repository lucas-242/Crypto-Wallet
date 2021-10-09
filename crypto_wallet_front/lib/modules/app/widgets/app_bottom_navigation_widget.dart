import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentPage;
  final Function(int) onTap;
  const AppBottomNavigationBar({
    Key? key,
    this.currentPage = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            blurRadius: 5.0,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 10.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) => onTap(index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor:
            AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                ? AppColors.white
                : AppColors.text,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: appLocalizations.dashboard,
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_balance_wallet),
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: appLocalizations.wallet),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: appLocalizations.trades,
          ),
        ],
      ),
    );
  }
}
