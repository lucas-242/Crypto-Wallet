import 'package:flutter/material.dart';

import 'app_colors.dart';

enum SnackBarType { success, error, none }

SnackBar getAppSnackBar({
  VoidCallback? onClose,
  SnackBarType type = SnackBarType.none,
  required String message,
}) {
  return SnackBar(
    content: Text(message),
    duration: Duration(seconds: 4),
    backgroundColor: type == SnackBarType.error
        ? AppColors.red
        : (type == SnackBarType.success ? AppColors.secondary : AppColors.grey),
    action: SnackBarAction(
      label: 'x',
      textColor: AppColors.stroke,
      onPressed: () => onClose,
    ),
  );
}
