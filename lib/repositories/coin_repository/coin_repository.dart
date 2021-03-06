import 'dart:convert';
import 'package:http/http.dart' as http;

import '/repositories/coin_repository/models/marketcap_api_response_model.dart';
import '/shared/core/build_configs.dart';
import '../../shared/core/cryptos.dart';

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
          '${Config.coingeckoApi}simple/price?ids=$formattedCoins&vs_currencies=$formattedCurrencies';
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
          '${Config.coingeckoApi}coins/$coin/ohlc?vs_currency=$currency&days=$days';
      var response = await http.get(Uri.parse(uri));
      return json.decode(response.body);
    } catch (error) {
      print(error.toString());
      throw Exception('Error getting OHLC: $error');
    }
  }

  ///Get the [coins] market data in the [currency]
  ///
  ///If [formattedCoins] is informed, ignore the [coins] for parameter creation
  ///
  /// Api limits to 50 results when using coins filter
  Future<List<MarketcapApiResponse>> getCoins({
    List<String> coins = const [],
    String currency = 'usd',
    int limit = 50,
    int page = 1,
    String? formattedCoins,
  }) async {
    try {
      if (formattedCoins == null) formattedCoins = _formatToUrl(coins);

      var uri =
          '${Config.coingeckoApi}coins/markets?ids=$formattedCoins&vs_currency=$currency&order=market_cap_desc&per_page=$limit&page=$page&sparkline=false&price_change_percentage=24h,7d,30d,1y';

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

  /// Get all app coins sorted by marketcap
  Future<List<MarketcapApiResponse>> getAppCoins() async {
    List<MarketcapApiResponse> response = [];
    var formattedCoins = _formatToUrl(Cryptos.list);

    var pages = (Cryptos.list.length / Config.apiResultLimit).ceil();

    for (var i = 0; i < pages; i++) {
      var coins = await getCoins(
        coins: Cryptos.list,
        limit: Config.apiResultLimit,
        page: i + 1,
        formattedCoins: formattedCoins,
      );
      response.addAll(coins);
    }

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
