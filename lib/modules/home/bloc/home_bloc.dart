import 'dart:ui';

import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/repositories/coin_repository/coin_repository.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/models/crypto_history_model.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/dashboard_model.dart';
import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:flutter/foundation.dart';

class HomeBloc extends ChangeNotifier {
  WalletRepository _walletRepository;
  CoinRepository _coinRepository;

  List<CryptoModel> cryptos = [];

  final statusNotifier = ValueNotifier<HomeStatus>(HomeStatus());

  HomeStatus get status => statusNotifier.value;
  set status(HomeStatus status) => statusNotifier.value = status;

  DashboardModel dashboardData = new DashboardModel();

  HomeBloc({
    required WalletRepository walletRepository,
    required CoinRepository coinRepository,
  })  : _walletRepository = walletRepository,
        _coinRepository = coinRepository;

  Future<void> getDashboardData(String uid) async {
    status = HomeStatus.loading();

    await _walletRepository.getAllCryptos(uid).then((result) async {
      if (result.isNotEmpty) {
        cryptos = await getCryptosMarketData(result);
        setDashboardData();
      }
    }).catchError((error) {
      status = HomeStatus.error(error.toString());
      print(error);
    });

    if (cryptos.isEmpty) {
      status = HomeStatus.noData();
    } else {
      status = HomeStatus();
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

  void eraseData() {
    cryptos = [];
    dashboardData = new DashboardModel();
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
    return [
      AppColors.primary,
      AppColors.secondary,
      AppColors.orange,
      AppColors.yellow,
      AppColors.grey,
      AppColors.red,
      AppColors.primary,
      AppColors.secondary,
      AppColors.orange,
      AppColors.yellow,
      AppColors.grey,
      AppColors.red,
    ];
  }
}
