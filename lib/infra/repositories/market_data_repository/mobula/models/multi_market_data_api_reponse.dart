import 'package:crypto_wallet/infra/repositories/market_data_repository/mobula/models/data_api_response.dart';
import 'package:equatable/equatable.dart';

class MultiMarketDataApiResponse extends Equatable {
  const MultiMarketDataApiResponse(this.entryMap);

  factory MultiMarketDataApiResponse.fromJson(Map<String, dynamic> json) =>
      MultiMarketDataApiResponse(getDataMap(json['data']));

  final Map<String, DataApiResponse> entryMap;

  static Map<String, DataApiResponse> getDataMap(Map<String, dynamic> map) {
    final Map<String, DataApiResponse> data = {};
    map.forEach((name, value) {
      data[name] = DataApiResponse.fromJson(value);
    });

    return data;
  }

  @override
  List<Object?> get props => [entryMap];
}
