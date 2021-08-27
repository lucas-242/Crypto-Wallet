import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/helpers/crypto_helper.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get Crypto API Ids from a CryptoModel list', () async {
    var coins = [
      CryptoModel(
        crypto: Cryptos.ada,
        amount: 500,
        averagePrice: 0.5,
        totalInvested: 250,
      ),
      CryptoModel(
        crypto: Cryptos.doge,
        amount: 500,
        averagePrice: 0.1,
        totalInvested: 10,
      ),
    ];

    var response = CryptoHelper.getCoinApiIdsFromList(coins);

    expect(response, equals([Cryptos.apiIds[Cryptos.ada], Cryptos.apiIds[Cryptos.doge]]));
  });
}
