import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

final _defaultTextStyle = GoogleFonts.inter(
  fontSize: AppFonts.sizeMd,
  fontWeight: AppFonts.regular,
  color: AppColors.text,
);

abstract class AppTextStyles {
  /// Size 32, Font 800
  static TextStyle get titleXXLg => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeXXLg,
        fontWeight: AppFonts.black,
      );

  /// Size 24, Font 800
  static TextStyle get titlexLg => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeXLg,
        fontWeight: AppFonts.black,
      );

  /// Size 20, Font 800
  static TextStyle get titleLg => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeLg,
        fontWeight: AppFonts.black,
      );

  /// Size 32, Font 600
  static TextStyle get subtitleXXLg => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeXXLg,
        fontWeight: AppFonts.bold,
      );

  /// Size 24, Font 600
  static TextStyle get subtitleXLg => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeXLg,
        fontWeight: AppFonts.bold,
      );

  /// Size 20, Font 600
  static TextStyle get subtitleLg => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeLg,
        fontWeight: AppFonts.bold,
      );

  /// Size 16, Font 600
  static TextStyle get subtitleMd => _defaultTextStyle.copyWith(
        fontWeight: AppFonts.bold,
      );

  /// Size 14, Font 600
  static TextStyle get subtitleSm => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeSm,
        fontWeight: AppFonts.bold,
      );

  /// Size 20, Font 400
  static TextStyle get lg =>
      _defaultTextStyle.copyWith(fontSize: AppFonts.sizeLg);

  /// Size 16, Font 400
  static TextStyle get md => _defaultTextStyle;

  /// Size 14, Font 400
  static TextStyle get sm =>
      _defaultTextStyle.copyWith(fontSize: AppFonts.sizeSm);

  /// Size 12, Font 400
  static TextStyle get xSm =>
      _defaultTextStyle.copyWith(fontSize: AppFonts.sizeXSm);

  /// Size 10, Font 400
  static TextStyle get xxSm => _defaultTextStyle.copyWith(
        fontSize: AppFonts.sizeXXSm,
      );
}
