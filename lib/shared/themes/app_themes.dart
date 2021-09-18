import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

//TODO: Finish and use these themes
abstract class AppThemes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primary,
    textTheme: TextTheme(
      headline1: AppTextStyles.logo,
      headline2: AppTextStyles.title,
      headline3: AppTextStyles.titleBold,
      headline4: AppTextStyles.cryptoTitle,
      headline5: AppTextStyles.cryptoTitleBold,
      bodyText1: AppTextStyles.bodyWhite,
      bodyText2: AppTextStyles.body,
      caption: AppTextStyles.bodyBold,
      // subtitle1:
      // subtitle2:
      // overline:
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primary,
    textTheme: TextTheme(
      headline1: AppTextStyles.logo,
      // headline2: AppTextStyles.logo,
      headline3: AppTextStyles.title,
      headline4: AppTextStyles.titleBold,
      headline5: AppTextStyles.cryptoTitle,
      headline6: AppTextStyles.cryptoTitleBold,
      bodyText1: AppTextStyles.bodyWhite,
      bodyText2: AppTextStyles.body,
      caption: AppTextStyles.bodyBold,
      // subtitle1:
      // subtitle2:
      // overline:
    ),
  );
}
