import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Firebase.initializeApp();
  final repository = new WalletRepository();
  final uid = '2TcEz5BbigUWjJ1hNfyHnrDu4oq1';
  final cryptoId = 'elrond-erd-2';

  final trade1 = TradeModel(
    operationType: TradeType.buy,
    cryptoId: cryptoId,
    amount: 0.07,
    amountDollars: 15.6,
    price: 222.80,
    date: DateTime(2021, 9, 10),
  );
  final trade2 = TradeModel(
    operationType: TradeType.sell,
    cryptoId: cryptoId,
    amount: 0.07,
    amountDollars: 16.05,
    price: 229.32,
    date: DateTime(2021, 9, 11),
  );
  final trade3 = TradeModel(
    operationType: TradeType.buy,
    cryptoId: cryptoId,
    amount: 0.13,
    amountDollars: 32.62,
    price: 250.95,
    date: DateTime(2021, 9, 17),
  );
  final trade4 = TradeModel(
    operationType: TradeType.buy,
    cryptoId: cryptoId,
    amount: 0.06,
    amountDollars: 11.65,
    price: 194.22,
    date: DateTime(2021, 9, 20),
  );

  // test('Adding a new Buy trade', () async {
  //   final oldTrades = [trade1, trade2, trade3];
  //   final newTrade = trade4;

  //   final crypto = CryptoModel(
  //     amount: 0.13,
  //     averagePrice: 250.95,
  //     totalInvested: 32.62,
  //     cryptoId: cryptoId,
  //     symbol: 'ELRG',
  //   );

  //   final response =
  //       repository.calculateCryptoProperties(crypto, oldTrades, newTrade);

  //   final expected = CryptoModel(
  //     amount: 0.19,
  //     averagePrice: 233.035,
  //     totalInvested: crypto.totalInvested + newTrade.amountDollars,
  //     cryptoId: cryptoId,
  //     symbol: 'ELRG',
  //     updatedAt: response.updatedAt,
  //   );
  //   print(response);
  //   expect(response, equals(expected));
  // });

  // test('Calculate Average Price', () async {
  //   final trades = [trade1, trade2, trade3, trade4];
  //   final totalAmount = 0.19;
  //   final response = repository.calculateAveragePrice(trades, totalAmount);
  //   print(response);
  //   expect(response, equals(233, 035));
  // });

//   test('get Bitcoin and Ada Cardano market data in USD', () async {
//     final response = await repository.getCoins(coins: [bitcoinId, cardanoId]);
//     print(response);
//     expect(response, isNot(equals(null)));
//     expect(response, isNot(equals(isEmpty)));
//   });

//   test('get Bitcoin OHLC within 7 days in USD', () async {
//     final response = await repository.getOHLC(coin: bitcoinId, days: 7);
//     print(response);
//     expect(response, isNot(equals(null)));
//     expect(response, isNot(equals(isEmpty)));
//   });

//   test('get at least the first 500 coins ordered by Marketcap', () async {
//     final response = await repository.getAppCoins();
//     print(response);
//     expect(response, equals(response.length >= 500));
//   });

  test('Get all user cryptos', () async {
    final response = await repository.getCryptos(uid);
    print(response);
    expect(response, equals(response.length >= 0));
  });
}
