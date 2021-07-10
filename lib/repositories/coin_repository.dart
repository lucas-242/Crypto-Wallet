import 'dart:convert';

import 'package:crypto_wallet/shared/environment/environment.dart';
import 'package:http/http.dart' as http;

class CoinRepository {
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
}
