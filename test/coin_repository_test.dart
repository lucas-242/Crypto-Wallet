import 'package:crypto_wallet/repositories/coin_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = new CoinRepository();

  test('get Bitcoin and Ada Cardano prices in Dollar', () async {
    final response = await repository.getPrices(coins: ['bitcoin', 'cardano']);
    print(response);
    expect(response, isNot(equals(null)));
  });
}
