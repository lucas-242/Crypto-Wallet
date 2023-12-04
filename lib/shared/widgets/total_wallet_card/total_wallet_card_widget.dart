import 'package:crypto_wallet/shared/models/wallet_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TotalWalletCard extends StatelessWidget {
  final WalletModel walletData;
  final bool showTotalInvested;
  final bool showUserTotal;
  const TotalWalletCard(
      {Key? key,
      required this.walletData,
      this.showTotalInvested = false,
      this.showUserTotal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    Widget hideValue({TextStyle? style}) => Text(
          '\$ ***',
          style: style ?? textTheme.displayMedium,
        );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showUserTotal
              ? Text(
                  NumberFormat.currency(symbol: '\$')
                      .format(walletData.totalNow),
                  style: textTheme.displayLarge,
                )
              : hideValue(style: textTheme.displayLarge),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showUserTotal
                  ? Text(
                      '${walletData.variation.isNegative ? '' : '+'} ${NumberFormat.currency(symbol: '\$').format(walletData.variation)}',
                      style: textTheme.displayMedium,
                    )
                  : hideValue(),
              Text(
                ' (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(walletData.percentVariation / 100)})',
                style: textTheme.displayMedium,
              ),
              Icon(
                  walletData.variation.isNegative
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: walletData.variation.isNegative
                      ? AppColors.red
                      : AppColors.green),
            ],
          ),
          showTotalInvested
              ? Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${appLocalizations.totalInvested}',
                        style: textTheme.displayMedium!.copyWith(fontSize: 17),
                      ),
              showUserTotal ?
                      Text(
                        NumberFormat.currency(symbol: '\$')
                            .format(walletData.totalInvested),
                        style: textTheme.displayMedium!.copyWith(fontSize: 17),
                      )
                      : hideValue(style: textTheme.displayMedium!.copyWith(fontSize: 17))
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
