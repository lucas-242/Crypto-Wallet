import 'package:flutter/material.dart';

class TradeDetailsRow extends StatelessWidget {
  final String leftText;
  final TextStyle? leftTextStyle;

  final String rightText;
  final TextStyle? rightTextStyle;

  const TradeDetailsRow({
    Key? key,
    required this.leftText,
    required this.rightText,
    this.leftTextStyle,
    this.rightTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: leftTextStyle),
        Text(rightText, style: rightTextStyle ?? textTheme.titleSmall),
      ],
    );
  }
}
