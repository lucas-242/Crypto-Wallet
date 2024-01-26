// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoSummary _$CryptoSummaryFromJson(Map<String, dynamic> json) =>
    CryptoSummary(
      cryptoId: json['cryptoId'] as String,
      crypto: json['crypto'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      color: json['color'] as int? ?? 0,
      value: (json['value'] as num?)?.toDouble() ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      percent: (json['percent'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CryptoSummaryToJson(CryptoSummary instance) =>
    <String, dynamic>{
      'cryptoId': instance.cryptoId,
      'crypto': instance.crypto,
      'name': instance.name,
      'color': instance.color,
      'image': instance.image,
      'value': instance.value,
      'amount': instance.amount,
      'percent': instance.percent,
    };
