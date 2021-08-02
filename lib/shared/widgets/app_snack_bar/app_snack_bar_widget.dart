import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, none }

//TODO: Use this snackBar
class AppSnackBar extends StatelessWidget {
  final SnackBarType type;
  final String message;
  const AppSnackBar({
    Key? key,
    required this.message,
    this.type = SnackBarType.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 4),
      backgroundColor: type == SnackBarType.error
          ? AppColors.red
          : (type == SnackBarType.success
              ? AppColors.secondary
              : AppColors.grey),
      action: SnackBarAction(
        label: 'x',
        textColor: AppColors.grey,
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );
  }
}
