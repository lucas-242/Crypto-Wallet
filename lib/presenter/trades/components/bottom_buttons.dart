import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
    required this.fisrtLabel,
    this.onPressedFirst,
    required this.secondLabel,
    this.onPressedSecond,
    this.firstButtonStyle,
    this.secondButtonStyle,
  }) : super(key: key);
  final String fisrtLabel;
  final VoidCallback? onPressedFirst;
  final String secondLabel;
  final VoidCallback? onPressedSecond;
  final TextStyle? firstButtonStyle;
  final TextStyle? secondButtonStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.085,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(thickness: 1, height: 1),
          SizedBox(
            height: context.height * 0.08,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onPressedFirst,
                    child: Text(
                      fisrtLabel,
                      style: firstButtonStyle ?? context.textSubtitleMd,
                    ),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: TextButton(
                    onPressed: onPressedSecond,
                    child: Text(
                      secondLabel,
                      style: secondButtonStyle ?? context.textSubtitleMd,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
