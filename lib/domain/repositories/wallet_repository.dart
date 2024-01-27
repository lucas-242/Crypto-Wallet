import 'package:crypto_wallet/domain/models/enums/trade_operartion.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';

abstract interface class WalletRepository {
  ///Fetch for all user's cryptos
  Future<List<WalletCrypto>> getCryptos();

  ///Fetch for an user's crypto considering the [cryptoId]
  Future<WalletCrypto?> getCryptoById(String cryptoId);

  ///Fetch for all user's trades filtering by [cryptoId] if it's not null
  Future<List<Trade>> getTrades({String? cryptoId});

  /// Create a [trade] and create/update the related [crypto] considering [operation]
  Future<void> addTrade(
    TradeCreateOperation operation,
    Trade trade,
    WalletCrypto crypto,
  );

  /// Delete a [trade] and update/delete the related [crypto] considering [operation]
  Future<void> deleteTrade(
    TradeDeleteOperation operation,
    Trade trade,
    WalletCrypto crypto,
  );
}
