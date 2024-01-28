import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return ListView.builder(
      itemCount: cryptos.length,
      itemBuilder: (context, index) {
        const priceChangePercentage = 10;
        // final priceChangePercentage = getPriceChangePercentage(time, index);

        return Container(
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
                        toBeginningOfSentenceCase(cryptos[index].name)!,
                        style: context.textTitleLg,
                      ),
                      Text(cryptos[index].symbol),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(NumberFormat.currency(symbol: '\$')
                          .format(cryptos[index].price)),
                      Row(
                        children: [
                          Text(
                            NumberFormat.decimalPercentPattern(decimalDigits: 1)
                                .format(priceChangePercentage / 100),
                          ),
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
    );
  }

  // double getPriceChangePercentage(WatchListTime time, int index) {
  //   switch (time) {
  //     case WatchListTime.percentage24h:
  //       return cryptos[index].priceChangePercentage24hInCurrency!;
  //     case WatchListTime.percentage7d:
  //       return cryptos[index].history!.priceChangePercentage7dInCurrency!;
  //     case WatchListTime.percentage30d:
  //       return cryptos[index].history!.priceChangePercentage30dInCurrency!;
  //     default:
  //       return cryptos[index].history!.priceChangePercentage1yInCurrency!;
  //   }
  // }
}
