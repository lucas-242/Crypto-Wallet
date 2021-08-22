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
        ? AppColors.grey
        : (type == SnackBarType.success ? AppColors.green : AppColors.red),
    action: SnackBarAction(
      label: 'x',
      textColor: AppColors.stroke,
      onPressed: () => onClose,
    ),
  );
}
