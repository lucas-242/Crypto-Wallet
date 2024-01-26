import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/widgets.dart';

abstract class AppSpacings {
  // Vertical space

  ///2px
  static const verticalTiny = SizedBox(height: AppInsets.tiny);

  ///4px
  static const verticalXXXSm = SizedBox(height: AppInsets.xxxSm);

  ///8px
  static const verticalXXSm = SizedBox(height: AppInsets.xxSm);

  ///10px
  static const verticalXSm = SizedBox(height: AppInsets.xSm);

  ///12px
  static const verticalSm = SizedBox(height: AppInsets.sm);

  ///16px
  static const verticalMd = SizedBox(height: AppInsets.md);

  ///24px
  static const verticalLg = SizedBox(height: AppInsets.lg);

  ///32px
  static const verticalXLg = SizedBox(height: AppInsets.xLg);

  ///40px
  static const verticalXXLg = SizedBox(height: AppInsets.xxLg);

  ///80px
  static const verticalHuge = SizedBox(height: AppInsets.huge);

  // Horizontal space

  ///2px
  static const horizontalTiny = SizedBox(width: AppInsets.tiny);

  ///4px
  static const horizontalXXXSm = SizedBox(width: AppInsets.xxxSm);

  ///8px
  static const horizontalXXSm = SizedBox(width: AppInsets.xxSm);

  ///10px
  static const horizontalXSm = SizedBox(width: AppInsets.xSm);

  ///12px
  static const horizontalSm = SizedBox(width: AppInsets.sm);

  ///16px
  static const horizontalMd = SizedBox(width: AppInsets.md);

  ///24px
  static const horizontalLg = SizedBox(width: AppInsets.lg);

  ///32px
  static const horizontalXLg = SizedBox(width: AppInsets.xLg);

  ///40px
  static const horizontalXXLg = SizedBox(width: AppInsets.xxLg);

  ///80px
  static const horizontalHuge = SizedBox(width: AppInsets.huge);

  static const empty = SizedBox.shrink();
}
