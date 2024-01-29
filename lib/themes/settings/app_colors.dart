import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFFFFAF2F);
  static const error = red;
  static const success = green;

  static const text = white;
  static const textLight = grey;
  static const background = black;

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF212121);
  static const overlay = Color(0x99222222);
  static const shadow = Color(0x25000000);
  static const transparent = Color(0x00000000);
  static const buttonOverlay = Color(0x0F424A57);

  static const grey = Color(0xFF424A57);
  static const blue = Color(0xFF5384A2);
  static const red = Color(0xFFCC0000);
  static const green = Color(0xFF00CC14);

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
}
