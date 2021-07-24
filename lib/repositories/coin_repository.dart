import 'dart:convert';

import 'package:crypto_wallet/shared/environment/environment.dart';
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
      String formattedCoins = coins.toString();
      formattedCoins = formattedCoins
          .substring(1, formattedCoins.length - 1)
          .replaceAll(RegExp(r"\s+"), '');

      String formattedCurrencies = currencies.toString();
      formattedCurrencies = formattedCurrencies
          .substring(1, formattedCurrencies.length - 1)
          .replaceAll(RegExp(r"\s+"), '');

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
}
