import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

void getCustomSnackBar(BuildContext context, {required String title}) {
  final overlayEntry = _getOverlayEntry(title);

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(seconds: 4))
      .then((value) => overlayEntry.remove());
}

OverlayEntry _getOverlayEntry(String title) => OverlayEntry(
      builder: (context) => Positioned(
        bottom: context.bottomBarHeight + AppInsets.lg,
        left: AppInsets.lg,
        right: AppInsets.lg,
        child: Material(
          elevation: 1,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppBorders.radiusMd)),
          color: AppColors.white,
          child: Container(
            padding: const EdgeInsets.all(AppInsets.md),
            height: AppSizes.snackbarHeight,
            child: Center(
              child: Text(
                title,
                style: context.textMd.copyWith(color: AppColors.textLight),
              ),
            ),
          ),
        ),
      ),
    );
