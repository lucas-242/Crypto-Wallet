import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_api_response.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class DataApiResponse extends Equatable {
  const DataApiResponse({
    this.ath = 0,
    this.atl = 0,
    this.isListed = false,
    this.liquidity = 0,
    this.liquidityChange24h = 0,
    this.marketCap = 0,
    this.marketCapDiluted = 0,
    this.offChainVolume = 0,
    this.price = 0,
    this.priceChange1h = 0,
    this.priceChange1m = 0,
    this.priceChange1y = 0,
    this.priceChange24h = 0,
    this.priceChange7d = 0,
    this.volume = 0,
    this.volume7d = 0,
    this.volumeChange24h = 0,
  });

  factory DataApiResponse.fromJson(Map<String, dynamic> json) =>
      _$DataApiResponseFromJson(json);

  final double ath;
  final double atl;
  final bool isListed;
  final double liquidity;
  @JsonKey(name: 'liquidity_change_24h')
  final double liquidityChange24h;
  final double marketCap;
  final double marketCapDiluted;
  final double offChainVolume;
  final double price;
  @JsonKey(name: 'price_change_1h')
  final double priceChange1h;
  @JsonKey(name: 'price_change_24h')
  final double priceChange24h;
  @JsonKey(name: 'price_change_7d')
  final double priceChange7d;
  @JsonKey(name: 'price_change_1m')
  final double priceChange1m;
  @JsonKey(name: 'price_change_1y')
  final double priceChange1y;
  final double volume;
  @JsonKey(name: 'volume_change_24h')
  final double volumeChange24h;
  @JsonKey(name: 'volume_7d')
  final double volume7d;

  @override
  List<Object?> get props => [
        ath,
        atl,
        isListed,
        liquidity,
        liquidityChange24h,
        marketCap,
        marketCapDiluted,
        offChainVolume,
        price,
        priceChange1h,
        priceChange1m,
        priceChange1y,
        priceChange24h,
        priceChange7d,
        volume,
        volume7d,
        volumeChange24h,
      ];
}
