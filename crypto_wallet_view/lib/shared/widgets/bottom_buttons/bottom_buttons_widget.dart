import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/label_button/label_button_widget.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final String fisrtLabel;
  final VoidCallback? onPressedFirst;
  final String secondLabel;
  final VoidCallback? onPressedSecond;
  final TextStyle? firstButtonStyle;
  final TextStyle? secondButtonStyle;

  const BottomButtons({
    Key? key,
    required this.fisrtLabel,
    this.onPressedFirst,
    required this.secondLabel,
    this.onPressedSecond,
    this.firstButtonStyle,
    this.secondButtonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: SizeConfig.height * 0.085,
      // color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: theme.dividerColor,
          ),
          Container(
            height: SizeConfig.height * 0.08,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: fisrtLabel,
                    onPressed: onPressedFirst,
                    style:
                        firstButtonStyle,
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: LabelButton(
                    label: secondLabel,
                    onPressed: onPressedSecond,
                    style:
                        secondButtonStyle,
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
