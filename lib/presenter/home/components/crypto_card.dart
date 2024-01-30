import 'package:crypto_wallet/core/components/image_fade/image_fade.dart';
import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({super.key, required this.crypto});
  final WalletCrypto crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppInsets.md),
      child: Card(
        color: crypto.marketData?.color,
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(AppInsets.md),
          width: context.width * .37,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageFade(image: crypto.marketData?.image),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: crypto.marketData?.symbol,
                      style: context.textSubtitleMd,
                      children: [
                        TextSpan(
                          text: ' - ${crypto.marketData?.name.capitalize()}',
                          style: context.textMd,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacings.verticalXXXSm,
                  Text(
                    '${crypto.amount.toStringAsFixed(8)} ',
                    style: context.textSubtitleMd,
                  ),
                  AppSpacings.verticalXXXSm,
                  Text(
                    crypto.percentInWallet.formatPercent(),
                    style: context.textMd.copyWith(color: AppColors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
