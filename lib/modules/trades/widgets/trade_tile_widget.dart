import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../widgets/trade_details_row_widget.dart';

class TradeTile extends StatelessWidget {
  final TradeModel trade;
  final void Function(TradeModel trade)? onDelete;
  final void Function(TradeModel trade)? onTap;
  const TradeTile({Key? key, required this.trade, this.onDelete, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap!(trade),
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                TradeDetailsRow(
                  leftText: trade.crypto,
                  leftTextStyle: AppTextStyles.captionBoldBody,
                  rightText: toBeginningOfSentenceCase(trade.operationType)!,
                  rightTextStyle: trade.operationType == TradeType.buy
                      ? AppTextStyles.captionBoldBody
                          .copyWith(color: AppColors.secondary)
                      : AppTextStyles.captionBoldBody
                          .copyWith(color: AppColors.red),
                ),
                SizedBox(height: 5),
                TradeDetailsRow(
                  leftText: 'Amount',
                  rightText: trade.amount.toStringAsFixed(8),
                ),
                SizedBox(height: 5),
                TradeDetailsRow(
                  leftText: 'Price',
                  rightText:
                      NumberFormat.currency(symbol: '\$').format(trade.price),
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: IconSlideAction(
            caption: 'Delete',
            icon: Icons.close,
            onTap: () => onDelete!(trade),
            foregroundColor: AppColors.text,
          ),
        ),
      ],
    );
  }
}
