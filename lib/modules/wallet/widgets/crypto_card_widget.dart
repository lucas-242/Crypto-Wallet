import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/app_text_styles.dart';
import 'package:crypto_wallet/shared/extensions/string_extension.dart';
import 'package:crypto_wallet/shared/themes/size_config.dart';
import 'package:crypto_wallet/shared/widgets/image_fade/image_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoCard extends StatefulWidget {
  final CryptoModel crypto;
  const CryptoCard({Key? key, required this.crypto}) : super(key: key);

  @override
  _CryptoCardState createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  double _animatedHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        _animatedHeight != 0.0
            ? _animatedHeight = 0.0
            : _animatedHeight = SizeConfig.height * 0.18;
      }),
      child: Card(
        elevation: 3,
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
                    Row(
                      children: [
                        ImageFade(image: widget.crypto.image),
                        SizedBox(width: 15),
                        Text.rich(
                          TextSpan(
                              text: widget.crypto.name.capitalize(),
                              children: [
                                TextSpan(text: ' . ${widget.crypto.crypto}')
                              ]),
                          style: AppTextStyles.cryptoTitleBold
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat.currency(symbol: '\$')
                              .format(widget.crypto.totalNow),
                          style:
                              AppTextStyles.cryptoTitle.copyWith(fontSize: 15),
                        ),
                        Text(
                          widget.crypto.amount.toStringAsFixed(8),
                          style:
                              AppTextStyles.cryptoTitle.copyWith(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  height: _animatedHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: AppTextStyles.cryptoTitle
                                  .copyWith(fontSize: 15),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(widget.crypto.price),
                              style: AppTextStyles.cryptoTitle
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Average price',
                              style: AppTextStyles.cryptoTitle
                                  .copyWith(fontSize: 15),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(widget.crypto.averagePrice),
                              style: AppTextStyles.cryptoTitle
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Gain / Loss',
                              style: AppTextStyles.cryptoTitle
                                  .copyWith(fontSize: 15),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(widget.crypto.gainLoss),
                              style: AppTextStyles.cryptoTitle
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
