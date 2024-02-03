import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class WalletCryptoCardOpened extends StatelessWidget {
  const WalletCryptoCardOpened({super.key, required this.crypto});

  final WalletCrypto crypto;

  @override
  Widget build(BuildContext context) {
    final marketData = crypto.marketData!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: crypto.isOpen ? context.height * 0.22 : 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacings.verticalMd,
            const Divider(thickness: 1),
            AppSpacings.verticalMd,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.current.price),
                Text(
                  marketData.currentPrice.formatCurrency(
                    marketData.currentPrice.getDecimalDigits(),
                  ),
                )
              ],
            ),
            AppSpacings.verticalMd,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.current.averagePrice,
                ),
                Text(crypto.averagePrice.formatCurrency(
                    marketData.currentPrice.getDecimalDigits())),
              ],
            ),
            AppSpacings.verticalMd,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.current.totalInvested,
                ),
                Text(crypto.totalInvested.formatCurrency(
                    marketData.currentPrice.getDecimalDigits())),
              ],
            ),
            AppSpacings.verticalMd,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.current.gainLoss),
                Row(
                  children: [
                    Text(
                      '${crypto.gainLoss.formatCurrency(marketData.currentPrice.getDecimalDigits())} (${crypto.gainLossPercent.formatPercent()})',
                    ),
                    AppSpacings.horizontalXXXSm,
                    Icon(
                      crypto.gainLoss.isNegative
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: crypto.gainLoss.isNegative
                          ? AppColors.red
                          : AppColors.green,
                      size: AppInsets.md,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
