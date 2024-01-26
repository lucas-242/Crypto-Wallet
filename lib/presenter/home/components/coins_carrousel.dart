import 'package:crypto_wallet/core/components/image_fade/image_fade.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/wallet.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinsCarrousel extends StatelessWidget {
  const CoinsCarrousel({super.key, required this.wallet});

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacings.verticalMd,
        Text(
          AppLocalizations.current.inYourWallet,
          style: context.textSubtitleMd,
        ),
        AppSpacings.verticalMd,
        SizedBox(
          height: context.height * 0.23,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: wallet.cryptosSummary.length,
              itemBuilder: (context, index) {
                final cryptoSummary = wallet.cryptosSummary[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: wallet.cryptosSummary.length == index + 1
                        ? 0
                        : AppInsets.xxSm,
                  ),
                  child: Row(
                    children: [
                      Card(
                        color: Color(cryptoSummary.color),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(AppInsets.md),
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
                                      style: context.textMd,
                                      children: [
                                        TextSpan(
                                          text:
                                              ' - ${toBeginningOfSentenceCase(cryptoSummary.name)}',
                                          style: context.textSm,
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  AppSpacings.verticalXXSm,
                                  Text(
                                    '${cryptoSummary.amount.toStringAsFixed(8)} ',
                                    style: context.textMd,
                                  ),
                                  AppSpacings.verticalXXSm,
                                  Text(
                                    NumberFormat.decimalPercentPattern(
                                            decimalDigits: 1)
                                        .format(cryptoSummary.percent / 100),
                                    style: context.textSm
                                        .copyWith(color: AppColors.white),
                                  ),
                                ],
                              )
                            ],
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
