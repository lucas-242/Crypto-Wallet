import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class TradeTile extends StatelessWidget {
  final TradeModel trade;
  const TradeTile({Key? key, required this.trade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        trade.crypto!,
        style: AppTextStyles.captionBoldBody,
      ),
      subtitle: Text(
        '${trade.amount!.toStringAsFixed(8)}',
        style: AppTextStyles.captionBody,
      ),
      trailing: Text.rich(
        TextSpan(
          text: 'Buy price',
          style: AppTextStyles.captionBoldBody,
          children: [
            TextSpan(
              text: "\n\$${trade.price!.toStringAsFixed(2)}",
              style: AppTextStyles.captionBody
            ),
          ],
        ),
      ),
    );
  }
}
