
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoSummary extends StatelessWidget {
  final CryptoModel crypto;
  const CryptoSummary({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Cryptos.BTC,
                textAlign: TextAlign.left,
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
                        Text(NumberFormat.currency(symbol: '\$').format(crypto.totalInvested)),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Average price'),
                        Text(NumberFormat.currency(symbol: '\$').format(crypto.averagePrice)),
                        SizedBox(height: 25),
                        Text('Gain / Loss'),
                        Text(NumberFormat.currency(symbol: '\$').format(crypto.gainLoss)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
