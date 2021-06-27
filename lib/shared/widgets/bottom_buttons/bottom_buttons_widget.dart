import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/label_button/label_button_widget.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback? onPressedPrimary;
  final String secondaryLabel;
  final VoidCallback? onPressedSecondary;
  final TextStyle? firstButtonColor;
  final TextStyle? secondButtonColor;

  const BottomButtons({
    Key? key,
    required this.primaryLabel,
    this.onPressedPrimary,
    required this.secondaryLabel,
    this.onPressedSecondary,
    this.firstButtonColor,
    this.secondButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.085,
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
          Container(
            height: size.height * 0.08,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: onPressedPrimary,
                    style:
                        firstButtonColor ?? AppTextStyles.buttonPrimary,
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: LabelButton(
                    label: secondaryLabel,
                    onPressed: onPressedSecondary,
                    style:
                        secondButtonColor ?? AppTextStyles.buttonPrimary,
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
