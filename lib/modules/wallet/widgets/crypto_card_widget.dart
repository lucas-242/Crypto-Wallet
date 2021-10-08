import 'package:crypto_wallet/shared/helpers/wallet_helper.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/image_fade/image_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return DefaultTextStyle(
      style: textTheme.headline4!,
      child: InkWell(
        onTap: () => widget
            .onTap(widget.openedIndex == widget.index ? null : widget.index),
        child: AnimatedContainer(
          duration: Duration(seconds: 0),
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.openedIndex == widget.index
                  ? theme.colorScheme.secondary
                  : theme.scaffoldBackgroundColor
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
                                text: '${widget.crypto.symbol}',
                                children: [
                                  TextSpan(
                                      text:
                                          ' - ${toBeginningOfSentenceCase(widget.crypto.name)}')
                                ],
                              ),
                              style: textTheme.headline5,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(NumberFormat.currency(symbol: '\$')
                              .format(widget.crypto.totalNow)),
                          Text(widget.crypto.amount.toStringAsFixed(8)),
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
                              Text(appLocalizations.price),
                              Text(NumberFormat.currency(
                                symbol: '\$',
                                decimalDigits: WalletHelper.getDecimalDigits(
                                    widget.crypto.price),
                              ).format(widget.crypto.price)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                appLocalizations.averagePrice,
                              ),
                              Text(NumberFormat.currency(
                                symbol: '\$',
                                decimalDigits: WalletHelper.getDecimalDigits(
                                    widget.crypto.price),
                              ).format(widget.crypto.averagePrice)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                appLocalizations.totalInvested,
                              ),
                              Text(
                                NumberFormat.currency(
                                  symbol: '\$',
                                  decimalDigits: WalletHelper.getDecimalDigits(
                                      widget.crypto.price),
                                ).format(widget.crypto.totalInvested),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(appLocalizations.gainLoss),
                              Row(
                                children: [
                                  Text(
                                    NumberFormat.currency(
                                          symbol: '\$',
                                          decimalDigits:
                                              WalletHelper.getDecimalDigits(
                                                  widget.crypto.price),
                                        ).format(widget.crypto.gainLoss) +
                                        ' (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(widget.crypto.gainLossPercent)})',
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
      ),
    );
  }
}
