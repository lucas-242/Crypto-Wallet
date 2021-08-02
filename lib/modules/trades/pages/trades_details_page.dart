import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/trade_details_row_widget.dart';

class TradesDetails extends StatelessWidget {
  const TradesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trade = ModalRoute.of(context)!.settings.arguments as TradeModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Details'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
        child: Column(
          children: [
            Center(
                child: Text(trade.crypto, style: AppTextStyles.titleRegular)),
            SizedBox(height: 25),
            TradeDetailsRow(
              leftText: 'Type',
              rightText:  toBeginningOfSentenceCase(trade.operationType)!,
              rightTextStyle: trade.operationType == TradeType.buy
                  ? AppTextStyles.captionBoldBody
                      .copyWith(color: AppColors.secondary)
                  : AppTextStyles.captionBoldBody
                      .copyWith(color: AppColors.red),
            ),
            SizedBox(height: 10),
            TradeDetailsRow(
              leftText: 'Amount',
              rightText: trade.amount.toStringAsFixed(8),
            ),
            SizedBox(height: 10),
            TradeDetailsRow(
              leftText: 'Price',
              rightText:
                  NumberFormat.currency(symbol: '\$').format(trade.price),
            ),
            SizedBox(height: 10),
            TradeDetailsRow(
              leftText: 'Date',
              rightText: DateFormat.yMd().format(trade.date),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            TradeDetailsRow(
              leftText: 'Fee',
              rightText: trade.fee.toStringAsFixed(8),
            ),
            SizedBox(height: 10),
            TradeDetailsRow(
              leftText: 'Total',
              rightText: NumberFormat.currency(symbol: '\$')
                  .format(trade.amountInvested),
            ),
          ],
        ),
      ),
    );
  }
}
