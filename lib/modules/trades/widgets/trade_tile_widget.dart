import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/models/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TradeTile extends StatelessWidget {
  final TradeModel trade;
  final VoidCallback? onDelete;
  const TradeTile({Key? key, required this.trade, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
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
              text:
                  '${trade.operationType == TradeType.BUY ? "Buy" : "Sell"} price',
              style: AppTextStyles.captionBoldBody,
              children: [
                TextSpan(
                    text:
                        "\n${NumberFormat.currency(symbol: '\$').format(trade.price!)}",
                    style: AppTextStyles.captionBody),
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: onDelete,
        ),
      ],
    );
  }
}
