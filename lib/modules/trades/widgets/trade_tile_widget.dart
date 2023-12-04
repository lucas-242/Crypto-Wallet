import 'package:crypto_wallet/shared/core/trade_type.dart';
import 'package:crypto_wallet/shared/helpers/view_helper.dart';
import 'package:crypto_wallet/shared/helpers/wallet_helper.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

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
    final theme = Theme.of(context);

    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: SlidableAction(
              label: appLocalizations.delete,
              icon: Icons.close,
              onPressed: (_) => onDelete!(trade),
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
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
                  leftTextStyle: theme.textTheme.titleSmall!
                      .copyWith(color: AppColors.primary),
                  rightText: toBeginningOfSentenceCase(ViewHelper.getTradeLabel(
                      trade.operationType, appLocalizations))!,
                  rightTextStyle: ViewHelper.getTradeColor(trade),
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
    );
  }
}
