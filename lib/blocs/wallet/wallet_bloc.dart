import 'dart:async';
import 'dart:ui';

import 'package:crypto_wallet/repositories/coin_repository/coin_repository.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/models/crypto_history_model.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/dashboard_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/foundation.dart';

import 'wallet_status.dart';

class WalletBloc extends ChangeNotifier {
  WalletRepository _walletRepository;
  CoinRepository _coinRepository;

  List<CryptoModel> cryptos = [];

  DashboardModel dashboardData = new DashboardModel();

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

    await _walletRepository.getAllCryptos(uid).then((result) async {
      if (result.isNotEmpty) {
        cryptos = await getCryptosMarketData(result);
        setDashboardData();
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

    return await _coinRepository
        .getMarketData(coins: coins.map((e) => e.name).toList())
        .then((response) {
      coins.forEach((coin) {
        response.any((element) {
          if (element.id == coin.name) {
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
    });
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

  void setDashboardData() {
    double total = cryptos
        .map((e) => e.totalNow)
        .fold(0, (previousValue, element) => previousValue + element);
    double variation = cryptos
        .map((e) => e.gainLoss)
        .fold(0, (previousValue, element) => previousValue + element);

    double percentVariation = (variation.abs() * 100) / total;

    List<CryptoSummary> cryptosSummary = [];
    var sortedCryptos = cryptos;
    var colorIndex = 0;
    sortedCryptos.sort((a, b) => b.totalNow.compareTo(a.totalNow));
    sortedCryptos.forEach((crypto) {
      cryptosSummary.add(CryptoSummary(
        name: crypto.name,
        crypto: crypto.crypto,
        value: crypto.totalNow,
        amount: crypto.amount,
        percent: (crypto.totalNow * 100) / total,
        color: chartColors[colorIndex],
        image: crypto.image,
      ));
      colorIndex++;
    });

    dashboardData = dashboardData.copyWith(
      total: total,
      variation: variation,
      percentVariation: percentVariation,
      cryptosSummary: cryptosSummary,
    );
  }

  List<Color> get chartColors {
    Color? lastColor;
    return List.generate(cryptos.length, (index) {
      if (lastColor == AppColors.primary)
        lastColor = AppColors.secondary;
      else if (lastColor == AppColors.secondary)
        lastColor = AppColors.tertiary;
      else if (lastColor == AppColors.tertiary)
        lastColor = AppColors.grey;
      else
        lastColor = AppColors.primary;

      return lastColor!;
    });
  }

  void eraseData() {
    cryptos = [];
    dashboardData = new DashboardModel();
    notifyListeners();
  }
}
