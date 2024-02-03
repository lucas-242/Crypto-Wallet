import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/presenter/wallet/components/wallet_crypto_card_closed.dart';
import 'package:crypto_wallet/presenter/wallet/components/wallet_crypto_card_opened.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class WalletCryptoCard extends StatefulWidget {
  const WalletCryptoCard({
    super.key,
    required this.crypto,
    required this.onTap,
  });

  final WalletCrypto crypto;
  final Function(WalletCrypto) onTap;

  @override
  State<WalletCryptoCard> createState() => _WalletCryptoCardState();
}

class _WalletCryptoCardState extends State<WalletCryptoCard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textMd,
      child: InkWell(
        onTap: () => widget.onTap(widget.crypto),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorders.radiusMd),
            color:
                widget.crypto.isOpen ? AppColors.black : AppColors.background,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: AppInsets.md,
                bottom: widget.crypto.isOpen ? AppInsets.md : 0,
                left: AppInsets.md,
                right: AppInsets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WalletCryptoCardClosed(crypto: widget.crypto),
                WalletCryptoCardOpened(crypto: widget.crypto),
                if (widget.crypto.isOpen) AppSpacings.verticalLg,
                const Divider(thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
