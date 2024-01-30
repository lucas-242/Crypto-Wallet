import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/wallet.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class WalletTotalCard extends StatelessWidget {
  const WalletTotalCard({
    super.key,
    required this.data,
    this.showTotalInvested = false,
    this.hideValues = false,
  });

  final Wallet data;
  final bool showTotalInvested;
  final bool hideValues;

  @override
  Widget build(BuildContext context) {
    Widget hideValue({TextStyle? style}) => Text(
          '\$ ***',
          style: style ?? context.textLg,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.lg),
      child: Column(
        children: [
          hideValues
              ? hideValue()
              : Text(
                  data.totalNow.formatCurrency(),
                  style: context.textSubtitleXLg,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hideValues
                  ? hideValue()
                  : Text(
                      '${data.variation.isNegative ? '-' : '+'} ${data.variation.formatCurrency()}',
                      style: context.textLg,
                    ),
              Text(
                ' (${data.percentVariation.formatPercent()})',
                style: context.textLg,
              ),
              Icon(
                data.variation.isNegative
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color:
                    data.variation.isNegative ? AppColors.red : AppColors.green,
              ),
            ],
          ),
          if (showTotalInvested)
            Padding(
              padding: const EdgeInsets.only(top: AppInsets.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.current.totalInvested,
                    style: context.textLg,
                  ),
                  hideValues
                      ? hideValue()
                      : Text(
                          data.totalInvested.formatCurrency(),
                          style: context.textLg,
                        ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
