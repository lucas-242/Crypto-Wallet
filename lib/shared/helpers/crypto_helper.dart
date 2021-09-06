import 'dart:ui';

import 'package:crypto_wallet/repositories/coin_repository/models/marketcap_api_response_model.dart';
import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';

abstract class CryptoHelper {
  static List<MarketcapApiResponse> _coinsList = [];
  static List<MarketcapApiResponse> get coinsList => _coinsList;

  ///Find coin in coinList by the [id]
  static MarketcapApiResponse findCoin(String id) {
    return _coinsList.firstWhere((e) => e.id == id);
  }

  /// Set the coinsList with the new [marketcapData] using [isUpdate] flag to consider if it's an update of the data
  static void setCoinsList(
      {required List<MarketcapApiResponse> marketcapData,
      bool isUpdate = false}) {
    if (isUpdate && _coinsList.length > 0) {
      var sort = false;
      marketcapData.forEach((coin) {
        var index = _coinsList.indexWhere((element) => coin.id == element.id);
        if (index > -1)
          _coinsList[index] = coin;
        else {
          _coinsList.add(coin);
          sort = true;
        }
      });
      if (sort) {
        _coinsList.sort((a, b) => a.marketCapRank.compareTo(b.marketCapRank));
      }
    } else {
      _coinsList = marketcapData;
    }
  }

  /// Check if the coinList is already filled
  static bool cryptosIsLoaded() {
    if (_coinsList.length == Cryptos.list.length) return true;

    return false;
  }

  ///Get coin color by [id]
  static Color getCoinColor(String id) {
    var found = findCoin(id);
    return Cryptos.colors[found.id] != null
        ? Color(Cryptos.colors[found.id]!)
        : AppColors.text;
  }
}
