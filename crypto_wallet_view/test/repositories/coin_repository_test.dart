import 'package:crypto_wallet/repositories/coin_repository/coin_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = new CoinRepository();
  final bitcoinId = 'bitcoin';
  final cardanoId = 'cardano';

  test('get Bitcoin and Cardano prices in USD', () async {
    final response = await repository.getPrices(coins: [bitcoinId, cardanoId]);
    print(response);
    expect(response, isNot(equals(null)));
    expect(response, isNot(equals(isEmpty)));
  });

  test('get Bitcoin and Ada Cardano market data in USD', () async {
    final response = await repository.getCoins(coins: [bitcoinId, cardanoId]);
    print(response);
    expect(response, isNot(equals(null)));
    expect(response, isNot(equals(isEmpty)));
  });

  test('get Bitcoin OHLC within 7 days in USD', () async {
    final response = await repository.getOHLC(coin: bitcoinId, days: 7);
    print(response);
    expect(response, isNot(equals(null)));
    expect(response, isNot(equals(isEmpty)));
  });

  test('get at least the first 500 coins ordered by Marketcap', () async {
    final response = await repository.getAppCoins();
    print(response);
    expect(response, equals(response.length >= 500));
  });
}
