import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.grey[850],
    accentColor: Colors.grey[900],
    iconTheme: IconThemeData(color: AppColors.white),
    primaryIconTheme: IconThemeData(color: AppColors.input),
    textTheme: TextTheme(
      headline1: AppTextStyles.logo.copyWith(color: AppColors.white),
      headline2: AppTextStyles.title.copyWith(color: AppColors.white),
      headline3: AppTextStyles.titleBold.copyWith(color: AppColors.white),
      headline4: AppTextStyles.cryptoTitle.copyWith(color: AppColors.white),
      headline5: AppTextStyles.cryptoTitleBold.copyWith(color: AppColors.white),
      bodyText1: AppTextStyles.bodyWhite,
      bodyText2: AppTextStyles.bodyWhite,
      subtitle1: AppTextStyles.bodyBoldWhite,
      subtitle2: AppTextStyles.bodyBoldWhite,
      caption: AppTextStyles.input,
      button: AppTextStyles.button.copyWith(color: AppColors.input),
      // overline:
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Color(0xFFFAFAFA),
    accentColor: Color(0xFFF5F5F5),
    iconTheme: IconThemeData(color: AppColors.text),
    primaryIconTheme: IconThemeData(color: AppColors.text),
    textTheme: TextTheme(
      headline1: AppTextStyles.logo,
      headline2: AppTextStyles.title,
      headline3: AppTextStyles.titleBold,
      headline4: AppTextStyles.cryptoTitle,
      headline5: AppTextStyles.cryptoTitleBold,
      bodyText1: AppTextStyles.bodyWhite,
      bodyText2: AppTextStyles.body,
      subtitle1: AppTextStyles.bodyBoldWhite,
      subtitle2: AppTextStyles.bodyBold,
      caption: AppTextStyles.input,
      button: AppTextStyles.button,

      // overline:
    ),
  );
}
