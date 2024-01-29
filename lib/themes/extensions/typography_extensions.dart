import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

extension TypographyExtension on BuildContext {
  /// Size 32, Font 800
  TextStyle get textTitleXXLg => AppTextStyles.titleXXLg;

  /// Size 24, Font 800
  TextStyle get textTitleXLg => AppTextStyles.titlexLg;

  /// Size 20, Font 800
  TextStyle get textTitleLg => AppTextStyles.titleLg;

  /// Size 32, Font 600
  TextStyle get textSubtitleXXLg => AppTextStyles.subtitleXXLg;

  /// Size 24, Font 600
  TextStyle get textSubtitleXLg => AppTextStyles.subtitleXLg;

  /// Size 20, Font 600
  TextStyle get textSubtitleLg => AppTextStyles.subtitleLg;

  /// Size 16, Font 600
  TextStyle get textSubtitleMd => AppTextStyles.subtitleMd;

  /// Size 14, Font 600
  TextStyle get textSubtitleSm => AppTextStyles.subtitleSm;

  /// Size 20, Font 400
  TextStyle get textLg => AppTextStyles.lg;

  /// Size 16, Font 400
  TextStyle get textMd => AppTextStyles.md;

  /// Size 14, Font 400
  TextStyle get textSm => AppTextStyles.sm;

  /// Size 12, Font 400
  TextStyle get textXSm => AppTextStyles.xSm;

  /// Size 10, Font 400
  TextStyle get textXXSm => AppTextStyles.xxSm;
}
