import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_wallet/modules/app/app.dart';
import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:crypto_wallet/shared/themes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback? onPressedDarkMode;
  final VoidCallback? onPressedShowTotal;
  final VoidCallback? onPressedLogout;
  const CustomDrawer(
      {Key? key,
      this.onPressedDarkMode,
      this.onPressedLogout,
      this.onPressedShowTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<Auth>();
    final user = auth.user!;
    final appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizeConfig.height * 0.16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(user.photoURL!),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(user.displayName!, style: textTheme.displayMedium),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                        AppColors.grey.withAlpha(15)),
                  ),
                  onPressed: onPressedDarkMode,
                  child:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.wb_sunny_outlined),
                                SizedBox(width: 15),
                                Text(appLocalizations.lightMode,
                                    style: textTheme.labelLarge),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.mode_night_outlined),
                                SizedBox(width: 15),
                                Text(appLocalizations.darkMode,
                                    style: textTheme.labelLarge),
                              ],
                            ),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                        AppColors.grey.withAlpha(15)),
                  ),
                  onPressed: onPressedShowTotal,
                  child: Consumer<AppBloc>(
                    builder: (context, appBloc, child) {
                      if (appBloc.showUserTotalOption) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.visibility_off_outlined),
                            SizedBox(width: 15),
                            Text(appLocalizations.hideTotal,
                                style: textTheme.labelLarge),
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.visibility_outlined),
                            SizedBox(width: 15),
                            Text(appLocalizations.showTotal,
                                style: textTheme.labelLarge),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                            AppColors.grey.withAlpha(15)),
                      ),
                      onPressed: onPressedLogout,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 15),
                          Text(appLocalizations.logout,
                              style: textTheme.labelLarge),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
