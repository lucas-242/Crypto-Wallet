import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    required this.currentScreen,
    required this.onChangePage,
  });

  final int currentScreen;
  final Function(int) onChangePage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: AppColors.shadow,
              ),
            ],
          ),
          child: BottomNavigationBar(
            onTap: onChangePage,
            currentIndex: currentScreen,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: context.textRobotoSubtitleTiny,
            unselectedLabelStyle: context.textRobotoSubtitleTiny,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.text,
            items: [
              _buildBottomNavigationBarItem(
                AppLocalizations.current.dashboard,
                Icons.home,
              ),
              _buildBottomNavigationBarItem(
                AppLocalizations.current.wallet,
                Icons.account_balance_wallet,
              ),
              _buildBottomNavigationBarItem(
                AppLocalizations.current.trades,
                Icons.history,
              ),
            ],
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String text,
    IconData icon,
  ) =>
      BottomNavigationBarItem(
        label: text,
        icon: Padding(
          padding: const EdgeInsets.only(bottom: AppInsets.xxxs),
          child: ImusicaIcon(icon),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: AppInsets.xxxs),
          child: ImusicaIcon(icon),
        ),
      );
}
