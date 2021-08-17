import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum WatchListTime {
  priceChangePercentage1yInCurrency,
  priceChangePercentage24hInCurrency,
  priceChangePercentage30dInCurrency,
  priceChangePercentage7dInCurrency,
}

class WatchList extends StatelessWidget {
  final List<CryptoModel> cryptos;
  final WatchListTime time;
  const WatchList({
    Key? key,
    required this.cryptos,
    this.time = WatchListTime.priceChangePercentage24hInCurrency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptos.length,
      itemBuilder: (context, index) {
        double cryptoPercentage;
        switch (time) {
          case WatchListTime.priceChangePercentage1yInCurrency:
            cryptoPercentage =
                cryptos[index].history!.priceChangePercentage1yInCurrency!;
            break;
          case WatchListTime.priceChangePercentage24hInCurrency:
            cryptoPercentage =
                cryptos[index].history!.priceChangePercentage24hInCurrency!;
            break;
          case WatchListTime.priceChangePercentage7dInCurrency:
            cryptoPercentage =
                cryptos[index].history!.priceChangePercentage7dInCurrency!;
            break;
          case WatchListTime.priceChangePercentage30dInCurrency:
            cryptoPercentage =
                cryptos[index].history!.priceChangePercentage30dInCurrency!;
            break;
          default:
            throw Exception();
        }

        return Container(
          child: Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                          style: AppTextStyles.captionBody,
                        ),
                        Text(
                          cryptos[index].crypto,
                          style: AppTextStyles.captionBody,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${NumberFormat.currency(symbol: '\$').format(cryptos[index].price)}',
                          style: AppTextStyles.captionBody,
                        ),
                        Row(
                          children: [
                            Text(
                                '${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(cryptoPercentage / 100)}',
                                style: AppTextStyles.captionBody),
                            Icon(
                              cryptoPercentage.isNegative
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: cryptoPercentage.isNegative
                                  ? AppColors.red
                                  : AppColors.secondary,
                              size: 15,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
