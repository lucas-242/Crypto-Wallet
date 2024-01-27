import 'package:crypto_wallet/core/utils/log_utils.dart';
import 'package:crypto_wallet/infra/repositories/market_data_repository/mobula/mobula_market_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = MobulaMarketDataRepository();

  test('get Bitcoin and Ada Cardano market data in USD', () async {
    final response = await repository.getMarketData(['BTC', 'ADA']);
    Log.info('getCoins response: \n\n$response');
    expect(response, isNot(equals(null)));
    expect(response, isNot(equals(isEmpty)));
  });

  // test('get at least the first 500 coins ordered by Marketcap', () async {
  //   final response = await repository.getAppCoins();
  //   Log.info('getAppCoins response: \n\n$response');
  //   expect(response, equals(response.length >= 500));
  // });
}
