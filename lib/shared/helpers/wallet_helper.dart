import '/repositories/coin_repository/models/marketcap_api_response_model.dart';
import '/shared/constants/config.dart';

abstract class WalletHelper {
 
  static List<MarketcapApiResponse> _coinsList = [];
  static List<MarketcapApiResponse> get coinsList => _coinsList;

  ///Get decimal digits according to the crypto [price]
  static int getDecimalDigits(double price) {
    return price < Config.smallCryptosPrice
        ? Config.decimalDigitsToSmallCryptos
        : Config.decimalDigitsToCryptos;
  }

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
  static bool coinsIsLoaded() {
    // ! Not all coins are being returned by the API
    if (_coinsList.length >= 400) return true;

    return false;
  }
}
