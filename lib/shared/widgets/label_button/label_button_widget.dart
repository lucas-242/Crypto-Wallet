import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final VoidCallback? onPressed;
  const LabelButton({Key? key, required this.label, this.onPressed, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.08,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: style ?? AppTextStyles.buttonGrey,
        ),
      ),
    );
  }
}
