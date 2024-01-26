// abstract interface class CoinsRepository {
//   ///Get the [coins] currency in the [currencies]
//   ///
//   ///Returns [{"bitcoin": { "usd": 32524.45 }]
//   Future<Map<String, dynamic>> getPrices({
//     required List<String> coins,
//     List<String> currencies = const ['usd'],
//   });

//   /// Get the [coin] Open-high-low-close chart data based on [currency] in [days]
//   ///
//   /// Returns [[1626552000000, 31833.02, 31845.12, 31738.99, 31787.61]]
//   ///
//   ///Where
//   ///
//   /// 1626552000000 (time),
//   ///
//   /// 31833.02 (open),
//   ///
//   /// 31845.12 (high),
//   ///
//   /// 31738.99 (low),
//   ///
//   /// 31787.61 (close),
//   ///
//   Future<List<dynamic>> getOHLC({
//     required String coin,
//     int days = 1,
//     String currency = 'usd',
//   });

//   ///Get the [coins] market data in the [currency]
//   ///
//   ///If [formattedCoins] is informed, ignore the [coins] for parameter creation
//   ///
//   /// Api limits to 50 results when using coins filter
//   Future<List<MarketcapApiResponse>> getCoins({
//     List<String> coins = const [],
//     String currency = 'usd',
//     int limit = 50,
//     int page = 1,
//     String? formattedCoins,
//   });

//   /// Get all app coins sorted by marketcap
//   Future<List<MarketcapApiResponse>> getAppCoins();
// }
