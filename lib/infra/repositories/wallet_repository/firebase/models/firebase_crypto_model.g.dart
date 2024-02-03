// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_crypto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseCryptoModel _$FirebaseCryptoModelFromJson(Map<String, dynamic> json) =>
    FirebaseCryptoModel(
      cryptoId: json['cryptoId'] as String,
      amount: (json['amount'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      totalInvested: (json['totalInvested'] as num).toDouble(),
      updatedAt:
          FirebaseCryptoModel._dateFromJson(json['updatedAt'] as Timestamp),
      soldPositionAt: FirebaseCryptoModel._dateNullableFromJson(
          json['soldPositionAt'] as Timestamp?),
      lastTradeAt:
          FirebaseCryptoModel._dateFromJson(json['lastTradeAt'] as Timestamp),
      totalFee: (json['totalFee'] as num).toDouble(),
      totalProfit: (json['totalProfit'] as num).toDouble(),
      user: json['user'] as String,
    );

Map<String, dynamic> _$FirebaseCryptoModelToJson(
        FirebaseCryptoModel instance) =>
    <String, dynamic>{
      'cryptoId': instance.cryptoId,
      'amount': instance.amount,
      'averagePrice': instance.averagePrice,
      'totalInvested': instance.totalInvested,
      'updatedAt': FirebaseCryptoModel._dateToJson(instance.updatedAt),
      'soldPositionAt':
          FirebaseCryptoModel._dateToJson(instance.soldPositionAt),
      'lastTradeAt': FirebaseCryptoModel._dateToJson(instance.lastTradeAt),
      'totalFee': instance.totalFee,
      'totalProfit': instance.totalProfit,
      'user': instance.user,
    };
