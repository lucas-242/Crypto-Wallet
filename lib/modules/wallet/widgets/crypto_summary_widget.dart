import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoSummary extends StatelessWidget {
  final CryptoModel crypto;
  const CryptoSummary({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(crypto.crypto, style: AppTextStyles.cryptoTitleBold),
                  Text(
                    NumberFormat.currency(symbol: '\$').format(crypto.price),
                    style: AppTextStyles.cryptoTitle,
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount'),
                        Text(crypto.amount.toStringAsFixed(8)),
                        SizedBox(height: 25),
                        Text('Total invested'),
                        Text(NumberFormat.currency(symbol: '\$')
                            .format(crypto.totalInvested)),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Average price'),
                        Text(NumberFormat.currency(symbol: '\$')
                            .format(crypto.averagePrice)),
                        SizedBox(height: 25),
                        Text('Gain / Loss'),
                        Text(NumberFormat.currency(symbol: '\$')
                            .format(crypto.gainLoss)),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:'),
                  Text(NumberFormat.currency(symbol: '\$')
                      .format(crypto.totalNow))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
