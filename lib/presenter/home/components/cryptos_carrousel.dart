import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/presenter/home/components/crypto_card.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class CryptosCarrousel extends StatelessWidget {
  const CryptosCarrousel({super.key, required this.cryptos});

  final List<WalletCrypto> cryptos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppInsets.md),
      child: Column(
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
                return CryptoCard(crypto: crypto);
              },
            ),
          ),
        ],
      ),
    );
  }
}
