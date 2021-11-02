import 'package:flutter/material.dart';

abstract class AppColors {
  static final primary = Color(0xFFFFAF2F);
  static final grey = Color(0xFF424A57);
  static final green = Color(0xFF00CC14);
  static final red = Color(0xFFCC0000);
  static final blue = Color(0xFF5384A2);
  static final white = Color(0xFFFFFFFF);

  static final text = grey;
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
