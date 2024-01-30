import 'package:crypto_wallet/core/components/image_fade/image_fade.dart';
import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/data/cryptos.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class CoinsCarrousel extends StatelessWidget {
  const CoinsCarrousel({super.key, required this.cryptos});

  final List<WalletCrypto> cryptos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.current.inYourWallet,
          style: context.textSubtitleLg,
        ),
        AppSpacings.verticalMd,
        SizedBox(
          height: context.height * 0.23,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                final info = Cryptos.supported
                    .firstWhere((e) => e.id == crypto.cryptoId);
                return Padding(
                  padding: const EdgeInsets.only(right: AppInsets.md),
                  child: Card(
                    color: info.color,
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(AppInsets.md),
                      width: context.width * .37,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageFade(image: info.image),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: info.symbol,
                                  style: context.textMd,
                                  children: [
                                    TextSpan(
                                      text: ' - ${info.name.capitalize()}',
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AppSpacings.verticalXXXSm,
                              Text(
                                '${crypto.amount.toStringAsFixed(8)} ',
                                style: context.textMd,
                              ),
                              Text(
                                '20.0000 ',
                                style: context.textMd,
                              ),
                              AppSpacings.verticalXXXSm,
                              Text(
                                crypto.percentInWallet.formatPercent(),
                                style: context.textSm
                                    .copyWith(color: AppColors.white),
                              ),
                              Text(
                                '20%',
                                style: context.textMd,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
