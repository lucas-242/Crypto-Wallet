import 'package:crypto_wallet/core/components/image_fade/image_fade.dart';
import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class WalletCryptoCardClosed extends StatelessWidget {
  const WalletCryptoCardClosed({super.key, required this.crypto});
  final WalletCrypto crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageFade(image: crypto.marketData!.image),
              AppSpacings.horizontalMd,
              Container(
                width: context.width * 0.32,
                height: context.height * 0.065,
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: crypto.marketData!.symbol,
                    children: [
                      TextSpan(
                        text: ' - ${crypto.marketData!.name.capitalize()}',
                        style: context.textMd,
                      )
                    ],
                  ),
                  style: context.textSubtitleMd,
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
                crypto.totalNow.formatCurrency(),
                style: context.textSubtitleMd,
              ),
              Text(crypto.amount.toStringAsFixed(8)),
            ],
          )
        ],
      ),
    );
  }
}
