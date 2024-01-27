// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataApiResponse _$DataApiResponseFromJson(Map<String, dynamic> json) =>
    DataApiResponse(
      ath: (json['ath'] as num?)?.toDouble() ?? 0,
      atl: (json['atl'] as num?)?.toDouble() ?? 0,
      isListed: json['is_listed'] as bool? ?? false,
      liquidity: (json['liquidity'] as num?)?.toDouble() ?? 0,
      liquidityChange24h:
          (json['liquidity_change_24h'] as num?)?.toDouble() ?? 0,
      marketCap: (json['market_cap'] as num?)?.toDouble() ?? 0,
      marketCapDiluted: (json['market_cap_diluted'] as num?)?.toDouble() ?? 0,
      offChainVolume: (json['off_chain_volume'] as num?)?.toDouble() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      priceChange1h: (json['price_change_1h'] as num?)?.toDouble() ?? 0,
      priceChange1m: (json['price_change_1m'] as num?)?.toDouble() ?? 0,
      priceChange1y: (json['price_change_1y'] as num?)?.toDouble() ?? 0,
      priceChange24h: (json['price_change_24h'] as num?)?.toDouble() ?? 0,
      priceChange7d: (json['price_change_7d'] as num?)?.toDouble() ?? 0,
      volume: (json['volume'] as num?)?.toDouble() ?? 0,
      volume7d: (json['volume_7d'] as num?)?.toDouble() ?? 0,
      volumeChange24h: (json['volume_change_24h'] as num?)?.toDouble() ?? 0,
    );
