import 'dart:async';

import 'package:crypto_wallet/repositories/coin_repository/coin_repository.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:flutter/foundation.dart';

import 'wallet_status.dart';

class WalletBloc extends ChangeNotifier {
  WalletRepository _walletRepository;
  CoinRepository _coinRepository;

  List<CryptoModel> cryptos = [];

  final statusNotifier = ValueNotifier<WalletStatus>(WalletStatus());

  WalletStatus get status => statusNotifier.value;
  set status(WalletStatus status) => statusNotifier.value = status;

  WalletBloc({
    required WalletRepository walletRepository,
    required CoinRepository coinRepository,
  })  : _walletRepository = walletRepository,
        _coinRepository = coinRepository;

  Future<void> getCryptos(String uid) async {
    status = WalletStatus.loading();

    await _walletRepository.getAllCryptos(uid).then((value) async {
      cryptos = await getCryptosPrice(value);
    }).catchError((error) {
      status = WalletStatus.error(error.toString());
      print(error);
    });

    if (cryptos.isEmpty) {
      status = WalletStatus.noData();
    } else {
      // setTimerToGetPrices();
      status = WalletStatus();
    }

    notifyListeners();
  }

  Future<List<CryptoModel>> getCryptosPrice(List<CryptoModel> coins) async {
    var result = <CryptoModel>[];
    return await _coinRepository
        .getPrices(coins: coins.map((e) => e.name).toList())
        .then((response) {
      coins.forEach((coin) {
        var price = double.parse(response[coin.name]['usd'].toString());
        result.add(coin.copyWith(price: price));
      });

      return result;
    });
  }

  /// Init a timer to refresh crypto prices
  void setTimerToGetPrices() {
    Timer.periodic(Duration(seconds: 60), (timer) async {
      var result = await getCryptosPrice(cryptos);
      if (result.isNotEmpty) cryptos = result;
      print('refreshed');
      notifyListeners();
    });
  }

  void updateCrypto(CryptoModel model) {
    var index = cryptos.indexWhere((element) => element.crypto == model.crypto);

    if (index == -1) {
      cryptos.add(model);
    } else {
      cryptos[index] = model;
    }

    notifyListeners();
  }

  void eraseData() {
    cryptos = [];
    notifyListeners();
  }
}
