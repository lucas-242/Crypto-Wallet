import 'package:crypto_wallet/repositories/coin_repository/coin_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = new CoinRepository();
  final bitcoinId = 'bitcoin';
  final cardanoId = 'cardano';

  // test('aiin', () {
  //   int precision = 100000000;

  //   // print((0.13 * precision).roundToDouble());
  //   // print((0.06 * precision).roundToDouble());
  //   // print((0.15 * precision).roundToDouble());

  //   final difference = (0.13 * precision).roundToDouble() +
  //       (0.06 * precision).roundToDouble() +
  //       (0.15 * precision).roundToDouble();

  //   final result = difference / precision;
  //   print(result);
  //   expect(result, equals(0.34));
  // });

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
