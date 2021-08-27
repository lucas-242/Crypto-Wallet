// import 'dart:convert';

// import 'package:crypto_wallet/shared/constants/cryptos.dart';
// import 'package:flutter/services.dart' show rootBundle;

// abstract class CryptoHelper {
//   static Future<String> getCryptoName(String crypto) async {
//     var found = await _search(crypto);

//     if (found.isEmpty) {
//       return '';
//     }

//     return found.first['name'];
//   }

//   static Future<String> getCryptoApiName(String crypto) async {
//     var found = await _search(crypto);

//     if (found.isEmpty) {
//       return '';
//     }

//     return found.first['id'];
//   }

//   static Future<List<String>> getAllCryptoApiNames() async {
//     var cryptos = await json.decode(await _getJson()) as List<dynamic>;

//     var found = cryptos.where((item) => Cryptos.list.contains(item['symbol']));

//     if (found.isEmpty) {
//       return [];
//     }

//     return found.map((e) => e['id'] as String).toList();
//   }

//   static Future<List<dynamic>> _search(String crypto) async {
//     var cryptos = await json.decode(await _getJson()) as List<dynamic>;

//     var found = cryptos.where((item) => item['symbol'] == crypto);

//     if (found.isEmpty) {
//       return [];
//     }

//     return found.toList();
//   }

//   static Future<String> _getJson() {
//     return rootBundle.loadString('assets/data/cryptos_data.json');
//   }
// }

import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';

abstract class CryptoHelper {
  ///Get a list of api ids from the [coins] list o CryptoModel
  static List<String> getCoinApiIdsFromList(List<CryptoModel> coins) {
    var apiCoins = Cryptos.list
        .where((element) => Cryptos.list.contains(coins.map((e) => e.crypto)))
        .toList();

    return apiCoins;
  }
}
