import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TradeTile extends StatelessWidget {
  final TradeModel trade;
  final VoidCallback? onDelete;
  final void Function(TradeModel trade)? onTap;
  const TradeTile(
      {Key? key, required this.trade, this.onDelete, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
            color: trade.operationType == TradeType.buy
                ? AppColors.secondary
                : AppColors.red,
            width: 3.0,
          )),
        ),
        child: GestureDetector(
          onTap: () => onTap!(trade),
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                trade.crypto,
                style: AppTextStyles.captionBoldBody,
              ),
              subtitle: Text(
                '${trade.amount.toStringAsFixed(8)}',
                style: AppTextStyles.captionBody,
              ),
              trailing: Text.rich(
                TextSpan(
                  text:
                      '${trade.operationType == TradeType.buy ? "Buy" : "Sell"} price',
                  style: AppTextStyles.captionBoldBody,
                  children: [
                    TextSpan(
                        text:
                            "\n${NumberFormat.currency(symbol: '\$').format(trade.price)}",
                        style: AppTextStyles.captionBody),
                  ],
                ),
              ),
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
            onTap: () => onDelete,
            foregroundColor: AppColors.body,
          ),
        ),
      ],
    );
  }
}
