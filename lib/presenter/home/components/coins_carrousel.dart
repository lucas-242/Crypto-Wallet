import 'package:crypto_wallet/core/components/image_fade/image_fade.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/crypto.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinsCarrousel extends StatelessWidget {
  const CoinsCarrousel({super.key, required this.cryptos});

  final List<Crypto> cryptos;

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
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: cryptos.length == index + 1 ? 0 : AppInsets.xxSm,
                  ),
                  child: Row(
                    children: [
                      Card(
                        color: crypto.color,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(AppInsets.md),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImageFade(image: crypto.image),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: crypto.name,
                                      style: context.textMd,
                                      children: [
                                        TextSpan(
                                          text:
                                              ' - ${toBeginningOfSentenceCase(crypto.name)}',
                                          style: context.textSm,
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  AppSpacings.verticalXXSm,
                                  // Text(
                                  //   '${crypto.amount.toStringAsFixed(8)} ',
                                  //   style: context.textMd,
                                  // ),
                                  AppSpacings.verticalXXSm,
                                  // Text(
                                  //   NumberFormat.decimalPercentPattern(
                                  //           decimalDigits: 1)
                                  //       .format(crypto.percent / 100),
                                  //   style: context.textSm
                                  //       .copyWith(color: AppColors.white),
                                  // ),
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
