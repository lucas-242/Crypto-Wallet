import 'dart:ui';

import 'package:crypto_wallet/repositories/coin_repository/models/marketcap_api_response_model.dart';
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
    if (isUpdate) {
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

  ///Get coin color by [id]
  static Color getCoinColor(String id) {
    var found = findCoin(id);
    return _colors[found.id] != null ? Color(_colors[found.id]!) : AppColors.text;
  }

  static const _colors = {
    'bitcoin': 0xFFF79319,
    'ethereum': 0xFF686f95,
    'cardano': 0xFF26508C,
    'binancecoin': 0xFFF3BA2F,
    'tether': 0xFF05AD85,
    'ripple': 0xFF5B5F64,
    'dogecoin': 0xFFBB9F36,
    'usd-coin': 0xFF2674C9,
    'polkadot': 0xFF343335,
    'solana': 0xFF8775DB,
    'uniswap': 0xFFFE1A87,
    'bitcoin-cash': 0xFF0AC18E,
    'binance-usd': 0xFFEDB70B,
    'terra-luna': 0xFFFFD952,
    'chainlink': 0xFF2E52AF,
    'litecoin': 0xFF222222,
    'internet-computer': 0xFF28A9E0,
    'matic-network': 0xFF8247E5,
    'wrapped-bitcoin': 0xFFF79319,
    'vechain': 0xFF4284BC,
    'stellar': 0xFF0F0F0F,
    'theta-token': 0xFFB1EBED,
    'ethereum-classic': 0xFF168F1A,
    'filecoin': 0xFF0090FF,
    'tron': 0xFFC12F26,
    'coti': 0xFF2D65B0,
  };
}
