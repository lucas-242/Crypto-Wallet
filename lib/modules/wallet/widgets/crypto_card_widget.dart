import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/app_text_styles.dart';
import 'package:crypto_wallet/shared/themes/size_config.dart';
import 'package:crypto_wallet/shared/widgets/image_fade/image_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CryptoCard extends StatefulWidget {
  final CryptoModel crypto;
  const CryptoCard({Key? key, required this.crypto}) : super(key: key);

  @override
  _CryptoCardState createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  bool isOpen = false;
  double height = SizeConfig.height * 0.22;
  late AppLocalizations appLocalizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context)!;
  }

  //TODO: Remove the card to keep the constance in the layout
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => isOpen = !isOpen),
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
                              text:
                                  toBeginningOfSentenceCase(widget.crypto.name),
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
                  height: isOpen ? height : 0,
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
                              appLocalizations.price,
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
                              appLocalizations.averagePrice,
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
                              appLocalizations.totalInvested,
                              style: AppTextStyles.cryptoTitle
                                  .copyWith(fontSize: 15),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(widget.crypto.totalInvested),
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
                              appLocalizations.gainLoss,
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
