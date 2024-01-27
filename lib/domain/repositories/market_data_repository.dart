import 'package:crypto_wallet/domain/models/crypto.dart';

abstract interface class MarketDataRepository {
  Future<List<Crypto>> getMarketData(List<String> symbols);
}
