// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_crypto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletCrypto _$WalletCryptoFromJson(Map<String, dynamic> json) => WalletCrypto(
      id: json['id'] as String?,
      cryptoId: json['cryptoId'] as String,
      amount: (json['amount'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      totalInvested: (json['totalInvested'] as num).toDouble(),
      percentInWallet: (json['percentInWallet'] as num?)?.toDouble() ?? 0,
      userId: json['user'] as String? ?? '',
      totalFee: (json['totalFee'] as num?)?.toDouble() ?? 0,
      totalProfit: (json['totalProfit'] as num?)?.toDouble() ?? 0,
      soldPositionAt: json['soldPositionAt'] == null
          ? null
          : DateTime.parse(json['soldPositionAt'] as String),
      lastTradeAt: json['lastTradeAt'] == null
          ? null
          : DateTime.parse(json['lastTradeAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$WalletCryptoToJson(WalletCrypto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cryptoId': instance.cryptoId,
      'amount': instance.amount,
      'averagePrice': instance.averagePrice,
      'totalInvested': instance.totalInvested,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'percentInWallet': instance.percentInWallet,
      'soldPositionAt': instance.soldPositionAt?.toIso8601String(),
      'lastTradeAt': instance.lastTradeAt.toIso8601String(),
      'totalFee': instance.totalFee,
      'totalProfit': instance.totalProfit,
      'user': instance.userId,
    };
