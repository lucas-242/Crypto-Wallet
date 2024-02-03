import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/presenter/wallet/components/wallet_crypto_card_closed.dart';
import 'package:crypto_wallet/presenter/wallet/components/wallet_crypto_card_opened.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class WalletCryptoCard extends StatefulWidget {
  const WalletCryptoCard({
    super.key,
    required this.crypto,
    required this.index,
    this.openedIndex,
    required this.onTap,
  });

  final WalletCrypto crypto;
  final int index;
  final int? openedIndex;
  final Function(int?) onTap;

  @override
  State<WalletCryptoCard> createState() => _WalletCryptoCardState();
}

class _WalletCryptoCardState extends State<WalletCryptoCard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textMd,
      child: InkWell(
        onTap: () => widget
            .onTap(widget.openedIndex == widget.index ? null : widget.index),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorders.radiusMd),
            color: widget.openedIndex == widget.index
                ? AppColors.black
                : AppColors.background,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: AppInsets.md,
                bottom: widget.openedIndex == widget.index ? AppInsets.md : 0,
                left: AppInsets.md,
                right: AppInsets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WalletCryptoCardClosed(crypto: widget.crypto),
                WalletCryptoCardOpened(
                  crypto: widget.crypto,
                  index: widget.index,
                  openedIndex: widget.openedIndex,
                ),
                if (widget.openedIndex == widget.index) AppSpacings.verticalLg,
                if (widget.openedIndex == widget.index ||
                    widget.openedIndex == widget.index + 1)
                  const Divider(thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
