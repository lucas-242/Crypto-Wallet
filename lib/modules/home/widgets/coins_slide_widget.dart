import 'package:crypto_wallet/shared/models/wallet_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/image_fade/image_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoinsSlide extends StatelessWidget {
  final WalletModel walletdData;
  const CoinsSlide({Key? key, required this.walletdData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          appLocalizations.inYourWallet,
          style: AppTextStyles.title,
        ),
        SizedBox(height: 15),
        Container(
          height: SizeConfig.height * 0.23,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: walletdData.cryptosSummary.length,
              itemBuilder: (context, index) {
                var cryptoSummary = walletdData.cryptosSummary[index];
                return Padding(
                  padding: EdgeInsets.only(
                      right: walletdData.cryptosSummary.length == index + 1
                          ? 0
                          : 7),
                  child: Row(
                    children: [
                      Container(
                        width: SizeConfig.width * 0.36,
                        child: Card(
                          color: cryptoSummary.color,
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageFade(image: cryptoSummary.image),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: cryptoSummary.crypto,
                                        style: AppTextStyles
                                            .bodyBoldWhite,
                                        children: [
                                          TextSpan(
                                            text:
                                                ' - ${toBeginningOfSentenceCase(cryptoSummary.name)}',
                                            style: AppTextStyles
                                                .bodyWhite,
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${cryptoSummary.amount.toStringAsFixed(8)} ',
                                      style: AppTextStyles
                                          .bodyBoldWhite,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(cryptoSummary.percent / 100)}',
                                      style:
                                          AppTextStyles.bodyWhite,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
