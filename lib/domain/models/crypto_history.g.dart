// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoHistory _$CryptoHistoryFromJson(Map<String, dynamic> json) =>
    CryptoHistory(
      priceChangePercentage1yInCurrency:
          (json['priceChangePercentage1yInCurrency'] as num?)?.toDouble(),
      priceChangePercentage24hInCurrency:
          (json['priceChangePercentage24hInCurrency'] as num?)?.toDouble(),
      priceChangePercentage30dInCurrency:
          (json['priceChangePercentage30dInCurrency'] as num?)?.toDouble(),
      priceChangePercentage7dInCurrency:
          (json['priceChangePercentage7dInCurrency'] as num?)?.toDouble(),
      high24h: (json['high24h'] as num?)?.toDouble(),
      low24h: (json['low24h'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CryptoHistoryToJson(CryptoHistory instance) =>
    <String, dynamic>{
      'priceChangePercentage1yInCurrency':
          instance.priceChangePercentage1yInCurrency,
      'priceChangePercentage24hInCurrency':
          instance.priceChangePercentage24hInCurrency,
      'priceChangePercentage30dInCurrency':
          instance.priceChangePercentage30dInCurrency,
      'priceChangePercentage7dInCurrency':
          instance.priceChangePercentage7dInCurrency,
      'high24h': instance.high24h,
      'low24h': instance.low24h,
    };
