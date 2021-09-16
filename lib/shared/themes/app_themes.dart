import 'package:flutter/material.dart';

//TODO: Finish these themes
abstract class AppThemes {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
      primaryColor: Color(0xff1f655d),
      accentColor: Color(0xff40bf7a),
      textTheme: TextTheme(),
      appBarTheme: AppBarTheme(color: Color(0xff1f655d)));

  static ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: Color(0xfff5f5f5),
      accentColor: Color(0xff40bf7a),
      textTheme: TextTheme(),
      appBarTheme: AppBarTheme(
          color: Color(0xff1f655d),
          actionsIconTheme: IconThemeData(color: Colors.white)));
}
