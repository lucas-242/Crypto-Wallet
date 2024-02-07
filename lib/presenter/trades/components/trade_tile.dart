import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TradeTile extends StatelessWidget {
  const TradeTile({
    super.key,
    required this.trade,
    this.onDelete,
    this.onTap,
  });

  final Trade trade;
  final void Function(Trade trade)? onDelete;
  final void Function(Trade trade)? onTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SlidableAction(
              label: AppLocalizations.current.delete,
              icon: Icons.close,
              onPressed: (_) => onDelete!(trade),
              backgroundColor: AppColors.background,
            ),
          ),
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap!(trade),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  trade.cryptoSymbol,
                  style:
                      context.textSubtitleMd.copyWith(color: AppColors.primary),
                ),
                Text(trade.operationType.capitalize())
              ],
            ),
            AppSpacings.verticalXXSm,
            Row(
              children: [
                Text(AppLocalizations.current.amount),
                Text(trade.amount.toStringAsFixed(8)),
              ],
            ),
            AppSpacings.verticalXXSm,
            if (trade.operationType != TradeType.transfer)
              Row(
                children: [
                  Text(AppLocalizations.current.price),
                  Text(trade.price.getDecimalDigits().formatCurrency()),
                ],
              )
            else
              Row(
                children: [
                  Text(AppLocalizations.current.fee),
                  Text(trade.fee.getDecimalDigits().formatCurrency()),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
