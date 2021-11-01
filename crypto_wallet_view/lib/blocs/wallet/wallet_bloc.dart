import 'dart:async';

import 'package:flutter/foundation.dart';

import '/repositories/coin_repository/coin_repository.dart';
import '/repositories/coin_repository/models/marketcap_api_response_model.dart';
import '/repositories/wallet_repository/wallet_repository.dart';
import '/shared/constants/config.dart';
import '/shared/helpers/view_helper.dart';
import '/shared/helpers/wallet_helper.dart';
import '/shared/models/crypto_history_model.dart';
import '/shared/models/crypto_model.dart';
import '/shared/models/wallet_model.dart';
import 'wallet_status.dart';

class WalletBloc extends ChangeNotifier {
  WalletRepository _walletRepository;
  CoinRepository _coinRepository;

  List<CryptoModel> cryptos = [];

  WalletModel walletData = new WalletModel();

  ///The index of the opened Crypto Card of the Wallet Page
  int? openedIndex;

  bool canRefresh = true;

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

    await _walletRepository.getCryptos(uid).then((result) async {
      if (result.isNotEmpty) {
        cryptos = await getCryptosMarketData(result);
        setWalletData();
      }
    }).catchError((error) {
      status = WalletStatus.error(error.toString());
      print(error);
    });

    if (cryptos.isEmpty) {
      status = WalletStatus.noData();
    } else {
      status = WalletStatus();
    }

    notifyListeners();
  }

  Future<List<CryptoModel>> getCryptosMarketData(
      List<CryptoModel> coins) async {
    var result = <CryptoModel>[];

    var pages = (coins.length / Config.apiResultLimit).ceil();
    pages = pages < 0 ? 0 : pages;
    if (canRefresh) {
      for (var i = 0; i < pages; i++) {
        await _coinRepository
            .getCoins(coins: coins.map((e) => e.cryptoId).toList())
            .then((marketcap) {
          result.addAll(setCryptoHistory(coins, marketcap));

          WalletHelper.setCoinsList(marketcapData: marketcap, isUpdate: true);
        });
      }
    } else {
      for (var i = 0; i < pages; i++) {
        result.addAll(setCryptoHistory(coins, WalletHelper.coinsList));
      }
    }
    setTimerToRefreshMarketcap();
    return result;
  }

  List<CryptoModel> setCryptoHistory(
    List<CryptoModel> coins,
    List<MarketcapApiResponse> marketcap,
  ) {
    var result = <CryptoModel>[];

    coins.forEach((coin) {
      marketcap.any((element) {
        if (coin.cryptoId == element.id) {
          var price = element.currentPrice;

          var history = new CryptoHistory(
            high24h: element.high24h,
            low24h: element.low24h,
            priceChangePercentage1yInCurrency:
                element.priceChangePercentage1yInCurrency,
            priceChangePercentage24hInCurrency:
                element.priceChangePercentage24hInCurrency,
            priceChangePercentage30dInCurrency:
                element.priceChangePercentage30dInCurrency,
            priceChangePercentage7dInCurrency:
                element.priceChangePercentage7dInCurrency,
          );

          result.add(coin.copyWith(
            price: price,
            image: element.image,
            history: history,
          ));
          return true;
        }

        return false;
      });
    });

    return result;
  }

  /// Set a timer to allow user get new marketcap from API
  void setTimerToRefreshMarketcap() {
    canRefresh = false;
    Future.delayed(Duration(seconds: 45)).then((value) {
      canRefresh = true;
    });
  }

  void updateCrypto(CryptoModel model) {
    var index = cryptos.indexWhere((element) => element.symbol == model.symbol);

    if (index == -1) {
      cryptos.add(model);
    } else {
      cryptos[index] = model;
    }

    notifyListeners();
  }

  void setWalletData() {
    double totalNow = cryptos
        .map((e) => e.totalNow)
        .fold(0, (previousValue, element) => previousValue + element);
    double totalInvested = cryptos
        .map((e) => e.totalInvested)
        .fold(0, (previousValue, element) => previousValue + element);
    double variation = cryptos
        .map((e) => e.gainLoss)
        .fold(0, (previousValue, element) => previousValue + element);

    double percentVariation = (variation.abs() * 100) / totalNow;

    List<CryptoSummary> cryptosSummary = [];
    var sortedCryptos = cryptos;
    sortedCryptos.sort((a, b) => b.totalNow.compareTo(a.totalNow));
    sortedCryptos.forEach((crypto) {
      cryptosSummary.add(CryptoSummary(
        cryptoId: crypto.cryptoId,
        name: crypto.name,
        crypto: crypto.symbol,
        value: crypto.totalNow,
        amount: crypto.amount,
        percent: (crypto.totalNow * 100) / totalNow,
        color: ViewHelper.getCoinColor(crypto.cryptoId),
        image: crypto.image,
      ));
    });

    walletData = walletData.copyWith(
      totalNow: totalNow,
      totalInvested: totalInvested,
      variation: variation,
      percentVariation: percentVariation,
      cryptosSummary: cryptosSummary,
    );
  }

  void eraseData() {
    cryptos = [];
    walletData = new WalletModel();
    notifyListeners();
  }
}
