import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:crypto_wallet/shared/themes/app_text_styles.dart';
import 'package:crypto_wallet/shared/themes/size_config.dart';
import 'package:crypto_wallet/shared/widgets/image_fade/image_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CryptoCard extends StatefulWidget {
  final CryptoModel crypto;
  final int index;
  final int? openedIndex;
  final Function(int?) onTap;
  const CryptoCard({
    Key? key,
    required this.crypto,
    required this.index,
    this.openedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _CryptoCardState createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  double height = SizeConfig.height * 0.22;
  late AppLocalizations appLocalizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget
          .onTap(widget.openedIndex == widget.index ? null : widget.index),
      child: AnimatedContainer(
        duration: Duration(seconds: 0),
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.openedIndex == widget.index
                ? Colors.grey[100]
                : AppColors.background,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,
                bottom: widget.openedIndex == widget.index ? 20 : 0,
                left: 20,
                right: 20),
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
                        Container(
                          width: SizeConfig.width * 0.32,
                          height: SizeConfig.height * 0.065,
                          alignment: Alignment.centerLeft,
                          child: Text.rich(
                            TextSpan(
                              text: '${widget.crypto.crypto}',
                              children: [
                                TextSpan(
                                  text:
                                      ' - ${toBeginningOfSentenceCase(widget.crypto.name)}',
                                  style: AppTextStyles.cryptoTitle
                                      .copyWith(fontSize: 15),
                                )
                              ],
                            ),
                            style: AppTextStyles.cryptoTitleBold
                                .copyWith(fontSize: 15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                  height: widget.openedIndex == widget.index ? height : 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Divider(thickness: 1),
                        SizedBox(height: 15),
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
                            Row(
                              children: [
                                Text(
                                  NumberFormat.currency(symbol: '\$')
                                          .format(widget.crypto.gainLoss) +
                                      ' (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(widget.crypto.gainLossPercent)})',
                                  style: AppTextStyles.cryptoTitle
                                      .copyWith(fontSize: 15),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  widget.crypto.gainLoss.isNegative
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: widget.crypto.gainLoss.isNegative
                                      ? AppColors.red
                                      : AppColors.green,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                widget.openedIndex == widget.index
                    ? Container()
                    : SizedBox(height: 20),
                widget.openedIndex == widget.index ||
                        widget.openedIndex == widget.index + 1
                    ? Container()
                    : Divider(thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
