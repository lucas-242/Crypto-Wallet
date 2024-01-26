import 'dart:io';

import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);

  double get width => _mediaQuery.size.width;

  double get height => _mediaQuery.size.height;

  double get appBarHeight => _mediaQuery.padding.top + kToolbarHeight;

  double get bottomBarHeight =>
      kBottomNavigationBarHeight + _mediaQuery.padding.bottom;

  ScreenSize get screenSize {
    switch (width) {
      case >= AppBreakPoints.xLg:
        return ScreenSize.xLg;
      case >= AppBreakPoints.lg:
        return ScreenSize.lg;
      case > AppBreakPoints.md:
        return ScreenSize.md;
      default:
        return ScreenSize.sm;
    }
  }

  T whenScreenSize<T>({
    T? xxLg,
    T? xLg,
    T? lg,
    T? md,
    required T child,
  }) {
    switch (width) {
      case >= AppBreakPoints.xxLg:
        return xxLg ?? xLg ?? lg ?? md ?? child;
      case >= AppBreakPoints.xLg:
        return xLg ?? lg ?? md ?? child;
      case >= AppBreakPoints.lg:
        return lg ?? md ?? child;
      case > AppBreakPoints.md:
        return md ?? child;
      default:
        return child;
    }
  }

  bool get isWeb => kIsWeb;

  bool get isMobile => !isWeb && (Platform.isIOS || Platform.isAndroid);

  bool get isDesktop =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  bool get isMobileOrWeb => isWeb || isMobile;

  bool get isDesktopOrWeb => isWeb || isDesktop;
}
