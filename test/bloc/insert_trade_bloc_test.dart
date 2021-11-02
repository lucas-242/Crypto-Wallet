import 'package:crypto_wallet/modules/insert_trade/bloc/insert_trade_bloc.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/services/cryptos_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/wallet_mock.dart';

void main() {
  final firestore = FakeFirebaseFirestore();
  final walletRepository = new WalletRepository(firestore: firestore);
  final cryptosService = new CryptosService();

  final bloc = new InsertTradeBloc(
      walletRepository: walletRepository, cryptosService: cryptosService);
  final mock = new WalletMock();

  //These tests will be in the backend

  test('Should add first trade', () async {
    // bloc.onSave(walletBloc: walletBloc, tradesBloc: tradesBloc, uid: uid);

    await bloc
        .addTrade(mock.trades[0])
        .catchError((error) => throw Exception(error.toString()));

    var cryptos = await walletRepository.getCryptos(mock.userId);
    var trades = await walletRepository.getTrades(mock.userId);

    print(cryptos.first);
    print(trades.first);

    expect(trades.length, greaterThan(0));
    expect(cryptos.length, greaterThan(0));
  });
  test('Should add trade: buy, buy, total sale, buy, partial sale', () {});
  test('Should add trade: buy, buy, buy between the others', () {});
  test('Should add trade: buy, buy, sale between the others', () {});
  test('Should not add trade: buy, buy, sale between the others', () {});
  test('Should add trade: buy, buy, transfer between the others', () {});
  test('Should not add trade: buy, buy, transfer between the others', () {});
  test('Should not add trade: buy, buy, total sale between the others', () {});
  test('Should delete last trade', () {});
  test('Should delete an old trade', () {});
  test('Should delete all trades', () {});
}
