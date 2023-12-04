import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.grey[850],
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: Color(0xFF212121),
      surface: Color(0xFF303030),
      background: Color(0xFF303030),
      onPrimary: AppColors.text,
      onSecondary: AppColors.white,
      onSurface: AppColors.white,
      onBackground: AppColors.white,
      onError: AppColors.text,
      error: AppColors.red,
    ),
    iconTheme: IconThemeData(color: AppColors.white),
    primaryIconTheme: IconThemeData(color: AppColors.input),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.logo.copyWith(color: AppColors.white),
      displayMedium: AppTextStyles.title.copyWith(color: AppColors.white),
      displaySmall: AppTextStyles.titleBold.copyWith(color: AppColors.white),
      headlineMedium:
          AppTextStyles.cryptoTitle.copyWith(color: AppColors.white),
      headlineSmall:
          AppTextStyles.cryptoTitleBold.copyWith(color: AppColors.white),
      bodyLarge: AppTextStyles.bodyWhite,
      bodyMedium: AppTextStyles.bodyWhite,
      titleMedium: AppTextStyles.bodyBoldWhite,
      titleSmall: AppTextStyles.bodyBoldWhite,
      bodySmall: AppTextStyles.input,
      labelLarge: AppTextStyles.button.copyWith(color: AppColors.input),
      // overline:
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Color(0xFFFAFAFA),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: Color(0xFF212121),
      surface: Color(0xFFF5F5F5),
      background: Color(0xFFF5F5F5),
      onPrimary: AppColors.text,
      onSecondary: AppColors.text,
      onSurface: AppColors.text,
      onBackground: AppColors.text,
      onError: AppColors.text,
      error: AppColors.red,
    ),
    iconTheme: IconThemeData(color: AppColors.text),
    primaryIconTheme: IconThemeData(color: AppColors.text),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.logo,
      displayMedium: AppTextStyles.title,
      displaySmall: AppTextStyles.titleBold,
      headlineMedium: AppTextStyles.cryptoTitle,
      headlineSmall: AppTextStyles.cryptoTitleBold,
      bodyLarge: AppTextStyles.bodyWhite,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodyBoldWhite,
      titleSmall: AppTextStyles.bodyBold,
      bodySmall: AppTextStyles.input,
      labelLarge: AppTextStyles.button,
      // overline:
    ),
  );
}
