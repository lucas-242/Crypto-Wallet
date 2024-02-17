import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';

/// This service is responsible for calculate the Crypto properties when creating or removing a trade
abstract class CryptosService {
  /// Calculate all [crypto] properties considering [trade].
  WalletCrypto setCryptoByOperation(WalletCrypto crypto, Trade trade);

  /// Used to recalculate all the [crypto] properties when deleting a [trade]
  /// considering all the [trades].
  ///
  ///If [trade] is null, only [trades] will be consider to calculate properties.
  ///Used when editing trades or after sold all [crypto] position
  WalletCrypto recalculatingWalletCrypto({
    required WalletCrypto crypto,
    required List<Trade> trades,
    Trade? trade,
  });
}
