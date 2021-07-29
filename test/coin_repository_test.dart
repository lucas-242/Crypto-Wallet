import 'package:crypto_wallet/repositories/coin_repository/coin_repository.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = new CoinRepository();

  test('get Bitcoin and Ada Cardano prices in USD', () async {
    final response = await repository.getPrices(coins: [Cryptos.API_NAME[Cryptos.BTC]!, Cryptos.API_NAME[Cryptos.ADA]!]);
    print(response);
    expect(response, isNot(equals(null)));
    expect(response, isNot(equals(isEmpty)));
  });

  test('get Bitcoin and Ada Cardano market data in USD', () async {
    final response = await repository.getMarketData(coins: [Cryptos.API_NAME[Cryptos.BTC]!, Cryptos.API_NAME[Cryptos.ADA]!]);
    print(response);
    expect(response, isNot(equals(null)));
    expect(response, isNot(equals(isEmpty)));
  });

  test('get Bitcoin OHLC within 7 days in USD', () async {
    final response = await repository.getOHLC(coin: Cryptos.API_NAME[Cryptos.BTC]!, days: 7);
    print(response);
    expect(response, isNot(equals(null)));
    expect(response, isNot(equals(isEmpty)));
  });
}
