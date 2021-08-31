import 'dart:convert';

import 'package:crypto_wallet/repositories/coin_repository/models/marketcap_api_response_model.dart';
import 'package:crypto_wallet/shared/constants/environment.dart';
import 'package:http/http.dart' as http;

class CoinRepository {
  ///Get the [coins] currency in the [currencies]
  ///
  ///Returns [{"bitcoin": { "usd": 32524.45 }]
  Future<Map<String, dynamic>> getPrices({
    required List<String> coins,
    List<String> currencies = const ['usd'],
  }) async {
    try {
      String formattedCoins = _formatToUrl(coins);
      String formattedCurrencies = _formatToUrl(currencies);
      var uri =
          '${Environment.coingeckoApi}simple/price?ids=$formattedCoins&vs_currencies=$formattedCurrencies';
      var response = await http.get(Uri.parse(uri));
      return json.decode(response.body);
    } catch (error) {
      print(error);
      throw Exception('Error getting prices: $error');
    }
  }

  /// Get the [coin] Open-high-low-close chart data based on [currency] in [days]
  ///
  /// Returns [[1626552000000, 31833.02, 31845.12, 31738.99, 31787.61]]
  ///
  ///Where
  ///
  /// 1626552000000 (time),
  ///
  /// 31833.02 (open),
  ///
  /// 31845.12 (high),
  ///
  /// 31738.99 (low),
  ///
  /// 31787.61 (close),
  ///
  Future<List<dynamic>> getOHLC({
    required String coin,
    int days = 1,
    String currency = 'usd',
  }) async {
    try {
      var uri =
          '${Environment.coingeckoApi}coins/$coin/ohlc?vs_currency=$currency&days=$days';
      var response = await http.get(Uri.parse(uri));
      return json.decode(response.body);
    } catch (error) {
      print(error.toString());
      throw Exception('Error getting OHLC: $error');
    }
  }

  ///Get the [coins] market data in the [currency]
  Future<List<MarketcapApiResponse>> getMarketcap({
    List<String> coins = const [],
    String currency = 'usd',
    int limit = 100,
    int page = 1,
  }) async {
    try {
      String formattedCoins = _formatToUrl(coins);

      var uri =
          '${Environment.coingeckoApi}coins/markets?ids=$formattedCoins&vs_currency=$currency&order=market_cap_desc&per_page=$limit&page=$page&sparkline=false&price_change_percentage=24h,7d,30d,1y';

      var response = await http.get(Uri.parse(uri));
      Iterable body = json.decode(response.body);
      var result = List<MarketcapApiResponse>.from(
          body.map((x) => MarketcapApiResponse.fromMap(x)));
      return result;
    } catch (error) {
      print(error.toString());
      throw Exception('Error getting Market Data: $error');
    }
  }

  /// Get the first 500 coins and some other fixed ones sorted by marketcap
  Future<List<MarketcapApiResponse>> getCoinsByMarketcap() async {
    var response = await getMarketcap(limit: 250);
    var secondPage = await getMarketcap(limit: 250, page: 2);
    response.addAll(secondPage);

    var otherCoinsList = ['lbry-credits'];
    List<String> finalOtherCoinsList = [];
    otherCoinsList.asMap().forEach((index, element) {
      if (!response.any((e) => e.id == element)) finalOtherCoinsList.add(element);
    });

    var other = await getMarketcap(coins: finalOtherCoinsList);
    response.addAll(other);

    return response;
  }

  /// Format [urlParameter] to a string to use in URL
  String _formatToUrl(List<String> urlParameter) {
    if (urlParameter.isEmpty) return '';

    var result = urlParameter.toString();
    result =
        result.substring(1, result.length - 1).replaceAll(RegExp(r"\s+"), '');
    return result;
  }
}
