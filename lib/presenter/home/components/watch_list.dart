import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

enum WatchListTime {
  percentage24h,
  percentage7d,
  percentage30d,
  percentage1y,
}

class WatchList extends StatelessWidget {
  const WatchList({
    Key? key,
    required this.cryptos,
    this.time = WatchListTime.percentage24h,
  }) : super(key: key);

  final List<WalletCrypto> cryptos;
  final WatchListTime time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppInsets.xxxSm),
      child: ListView.builder(
        itemCount: cryptos.length,
        itemBuilder: (context, index) {
          final crypto = cryptos[index];
          final priceChangePercentage = getPriceChange(time, crypto);
          final marketData = crypto.marketData!;

          return Padding(
            padding: const EdgeInsets.only(
              top: AppInsets.xxxSm,
              left: AppInsets.xxSm,
              right: AppInsets.xxSm,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          marketData.name.capitalize(),
                          style: context.textTitleLg,
                        ),
                        Text(marketData.symbol),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(marketData.currentPrice.formatCurrency()),
                        Row(
                          children: [
                            Text(priceChangePercentage.formatPercent()),
                            Icon(
                              priceChangePercentage.isNegative
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: priceChangePercentage.isNegative
                                  ? AppColors.red
                                  : AppColors.green,
                              size: AppInsets.md,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                AppSpacings.verticalXXXSm,
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }

  double getPriceChange(WatchListTime time, WalletCrypto crypto) {
    switch (time) {
      case WatchListTime.percentage24h:
        return crypto.marketData?.priceChange24h ?? 0;
      case WatchListTime.percentage7d:
        return crypto.marketData?.priceChange7d ?? 0;
      case WatchListTime.percentage30d:
        return crypto.marketData?.priceChange30d ?? 0;
      default:
        return crypto.marketData?.priceChange1y ?? 0;
    }
  }
}
