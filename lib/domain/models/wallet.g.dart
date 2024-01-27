// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      totalNow: (json['totalNow'] as num?)?.toDouble() ?? 0,
      totalInvested: (json['totalInvested'] as num?)?.toDouble() ?? 0,
      variation: (json['variation'] as num?)?.toDouble() ?? 0,
      percentVariation: (json['percentVariation'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'totalNow': instance.totalNow,
      'totalInvested': instance.totalInvested,
      'variation': instance.variation,
      'percentVariation': instance.percentVariation,
    };
