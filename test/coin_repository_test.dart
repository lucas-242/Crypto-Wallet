import 'package:crypto_wallet/repositories/coin_repository.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = new CoinRepository();

  test('get Bitcoin and Ada Cardano prices in USD', () async {
    final response = await repository.getPrices(coins: ['bitcoin', 'cardano']);
    print(response);
    expect(response, isNot(equals(null)));
  });

  test('get Bitcoin OHLC within 7 days in USD', () async {
    final response = await repository.getOHLC(coin: Cryptos.API_NAME[Cryptos.BTC]!, days: 7);
    print(response);
    expect(response, isNot(equals(null)));
  });
}
