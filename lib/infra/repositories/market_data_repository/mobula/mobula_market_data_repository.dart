import 'dart:convert';
import 'dart:io';

import 'package:crypto_wallet/core/environment/environment.dart';
import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/utils/log_utils.dart';
import 'package:crypto_wallet/domain/data/cryptos.dart';
import 'package:crypto_wallet/domain/models/crypto.dart';
import 'package:crypto_wallet/domain/repositories/market_data_repository.dart';
import 'package:crypto_wallet/infra/repositories/market_data_repository/mobula/models/multi_market_data_api_reponse.dart';
import 'package:http/http.dart' as http;

final class MobulaMarketDataRepository implements MarketDataRepository {
  @override
  Future<List<Crypto>> getMarketData(List<String> symbols) async {
    try {
      final uri =
          '${Environment.mobulaApi}/market/multi-data?symbols=${_formatToUrl(symbols)}';

      final response = await http.get(Uri.parse(uri));
      final body = json.decode(response.body);
      final result = _convertBodyToCrypto(body);

      return result;
    } on SocketException catch (error) {
      Log.error(
          'No internet available to get market data for $symbols: ${error.toString()}');
      throw NoConnectionError(
          'No internet available to get market data for $symbols');
    } catch (error) {
      Log.error('Error to get market data for $symbols: ${error.toString()}');
      throw ExternalError('Error to get market data for $symbols');
    }
  }

  /// Format [urlParameter] to a string to use in URL
  String _formatToUrl(List<String> urlParameter) {
    if (urlParameter.isEmpty) return '';

    var result = urlParameter.toString();
    result =
        result.substring(1, result.length - 1).replaceAll(RegExp(r'\s+'), '');
    return result;
  }

  List<Crypto> _convertBodyToCrypto(Map<String, dynamic> body) {
    final apiResponse = MultiMarketDataApiResponse.fromJson(body);
    final response = <Crypto>[];

    apiResponse.entryMap.forEach((key, value) {
      final supported = Cryptos.supported.firstWhere((x) => x.symbol == key);
      response.add(Crypto(
        id: supported.id,
        name: supported.name,
        symbol: supported.symbol,
        color: supported.color,
        image: supported.image,
        currentPrice: value.price,
        // high24h: value.volumeChange24h,
        // low24h: value.low24h,
        priceChange24h: value.priceChange24h,
        priceChange7d: value.priceChange7d,
        priceChange30d: value.priceChange1m,
        priceChange1y: value.priceChange1y,
      ));
    });

    return response;
  }
}
