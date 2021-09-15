import 'package:crypto_wallet/shared/auth/auth.dart';
import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:crypto_wallet/shared/themes/app_text_styles.dart';
import 'package:crypto_wallet/shared/themes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback? onPressedDarkMode;
  final VoidCallback? onPressedLogout;
  const CustomDrawer({Key? key, this.onPressedDarkMode, this.onPressedLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<Auth>();
    final user = auth.user!;
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
                Text(user.displayName!, style: AppTextStyles.titleRegular),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.mode_night_outlined,
                        color: AppColors.grey,
                      ),
                      SizedBox(width: 15),
                      Text('Dark Mode', style: AppTextStyles.buttonGrey),
                    ],
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
                          Icon(
                            Icons.logout,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 15),
                          Text('Logout', style: AppTextStyles.buttonGrey),
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
