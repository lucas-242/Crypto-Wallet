import 'package:flutter/material.dart';

abstract class AppColors {
  static final primary = Color(0xFFFFAF2F);
  static final secondary = Color(0xFF294563);
  static final tertiary = Color(0xFF5384A2);
  static final grey = Color(0xFFC9D4E3);
  static final text = Color(0xFF6F7D90);
  static final textLight = Color(0xFFB3B9C5);
  static final background = Color(0xFFFFFFFF);

  static final yellow = Color(0xFFF2D83F);
  static final orange = Color(0xFFBF6932);
  static final red = Color(0xFFF27D6F);
  static final input = Color(0xFFB1B0B8);
  static final stroke = Color(0xFFE3E3E6);
  static final shape = Color(0xFFFAFAFC);

  static final primarySwatch = MaterialColor(0xFFFFAF2F, {
    50: Color.fromRGBO(255, 175, 47, .1),
    100: Color.fromRGBO(255, 175, 47, .2),
    200: Color.fromRGBO(255, 175, 47, .3),
    300: Color.fromRGBO(255, 175, 47, .4),
    400: Color.fromRGBO(255, 175, 47, .5),
    500: Color.fromRGBO(255, 175, 47, .6),
    600: Color.fromRGBO(255, 175, 47, .7),
    700: Color.fromRGBO(255, 175, 47, .8),
    800: Color.fromRGBO(255, 175, 47, .9),
    900: Color.fromRGBO(255, 175, 47, 1),
  });
}
