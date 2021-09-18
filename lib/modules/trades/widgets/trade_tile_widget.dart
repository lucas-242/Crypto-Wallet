import 'package:crypto_wallet/shared/helpers/trade_helper.dart';
import 'package:crypto_wallet/shared/helpers/wallet_helper.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/trade_details_row_widget.dart';

class TradeTile extends StatelessWidget {
  final TradeModel trade;
  final void Function(TradeModel trade)? onDelete;
  final void Function(TradeModel trade)? onTap;
  const TradeTile({Key? key, required this.trade, this.onDelete, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

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
                  leftText: trade.cryptoSymbol,
                  leftTextStyle: AppTextStyles.bodyBold
                      .copyWith(color: AppColors.primary),
                  rightText: toBeginningOfSentenceCase(
                      TradeTypeHelper.getTradeLabel(
                          trade.operationType, appLocalizations))!,
                  rightTextStyle: TradeTypeHelper.getTradeColor(trade),
                ),
                SizedBox(height: 5),
                TradeDetailsRow(
                  leftText: appLocalizations.amount,
                  rightText: trade.amount.toStringAsFixed(8),
                ),
                SizedBox(height: 5),
                if (trade.operationType != TradeType.transfer)
                  TradeDetailsRow(
                    leftText: appLocalizations.price,
                    rightText: NumberFormat.currency(
                      symbol: '\$',
                      decimalDigits: WalletHelper.getDecimalDigits(trade.price),
                    ).format(trade.price),
                  )
                else
                  TradeDetailsRow(
                    leftText: appLocalizations.fee,
                    rightText: NumberFormat.currency(
                      symbol: '\$',
                      decimalDigits: WalletHelper.getDecimalDigits(trade.fee),
                    ).format(trade.fee),
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
            caption: appLocalizations.delete,
            icon: Icons.close,
            onTap: () => onDelete!(trade),
            foregroundColor: AppColors.text,
          ),
        ),
      ],
    );
  }
}
