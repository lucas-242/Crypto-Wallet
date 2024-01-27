// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_crypto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletCrypto _$WalletCryptoFromJson(Map<String, dynamic> json) => WalletCrypto(
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      name: json['name'] as String? ?? '',
      image: json['image'] as String?,
      symbol: json['symbol'] as String,
      cryptoId: json['cryptoId'] as String,
      amount: (json['amount'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      totalInvested: (json['totalInvested'] as num).toDouble(),
      user: json['user'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      totalFee: (json['totalFee'] as num?)?.toDouble() ?? 0,
      totalProfit: (json['totalProfit'] as num?)?.toDouble() ?? 0,
      soldPositionAt: json['soldPositionAt'] == null
          ? null
          : DateTime.parse(json['soldPositionAt'] as String),
      lastTradeAt: json['lastTradeAt'] == null
          ? null
          : DateTime.parse(json['lastTradeAt'] as String),
    );

Map<String, dynamic> _$WalletCryptoToJson(WalletCrypto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'symbol': instance.symbol,
      'cryptoId': instance.cryptoId,
      'amount': instance.amount,
      'averagePrice': instance.averagePrice,
      'totalInvested': instance.totalInvested,
      'price': instance.price,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'soldPositionAt': instance.soldPositionAt?.toIso8601String(),
      'lastTradeAt': instance.lastTradeAt.toIso8601String(),
      'totalFee': instance.totalFee,
      'totalProfit': instance.totalProfit,
      'user': instance.user,
    };
