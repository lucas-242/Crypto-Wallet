import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

//TODO: Finish and use these themes
abstract class AppThemes {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff1f655d),
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,
    accentColor: AppColors.primary,
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
