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
    required this.isNextCardOpen,
  });

  final WalletCrypto crypto;
  final Function(WalletCrypto) onTap;
  final bool isNextCardOpen;

  @override
  State<WalletCryptoCard> createState() => _WalletCryptoCardState();
}

class _WalletCryptoCardState extends State<WalletCryptoCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.crypto),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorders.radiusMd),
          color: widget.crypto.isOpen ? AppColors.black : AppColors.background,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppInsets.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletCryptoCardClosed(crypto: widget.crypto),
              if (widget.isNextCardOpen) AppSpacings.verticalLg,
              WalletCryptoCardOpened(crypto: widget.crypto),
              if (!widget.crypto.isOpen && !widget.isNextCardOpen) ...[
                AppSpacings.verticalLg,
                const Divider(thickness: 1),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
