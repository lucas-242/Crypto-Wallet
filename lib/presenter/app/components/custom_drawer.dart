import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:crypto_wallet/presenter/app/components/custom_avatar.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    this.onPressedLogout,
    this.onPressedShowTotal,
    required this.user,
  }) : super(key: key);

  final VoidCallback? onPressedShowTotal;
  final VoidCallback? onPressedLogout;

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppInsets.huge,
        left: AppInsets.lg,
        right: AppInsets.lg,
        bottom: AppInsets.md,
      ),
      child: Column(
        children: [
          Column(
            children: [
              CustomAvatar(image: user.photoUrl),
              AppSpacings.verticalMd,
              Text(user.name, style: context.textSubtitleLg),
            ],
          ),
          AppSpacings.verticalMd,
          TextButton(
            onPressed: onPressedShowTotal,
            style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(AppColors.buttonOverlay),
            ),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Icon(
                      state.showWalletValues
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    AppSpacings.horizontalSm,
                    Text(
                      state.showWalletValues
                          ? AppLocalizations.current.hideTotal
                          : AppLocalizations.current.showTotal,
                      style: context.textMd,
                    ),
                  ],
                );
              },
            ),
          ),
          const Spacer(),
          TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all<Color>(AppColors.textLight),
            ),
            onPressed: onPressedLogout,
            child: Row(
              children: [
                const Icon(Icons.logout),
                AppSpacings.horizontalMd,
                Text(
                  AppLocalizations.current.logout,
                  style: context.textMd,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
