// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) => Trade(
      id: json['id'] as String? ?? '',
      operationType: json['operationType'] as String? ?? '',
      cryptoSymbol: json['cryptoSymbol'] as String? ?? '',
      cryptoId: json['cryptoId'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      amountDollars: (json['amountDollars'] as num?)?.toDouble() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      fee: (json['fee'] as num?)?.toDouble() ?? 0,
      profit: (json['profit'] as num?)?.toDouble() ?? 0,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'id': instance.id,
      'operationType': instance.operationType,
      'cryptoSymbol': instance.cryptoSymbol,
      'cryptoId': instance.cryptoId,
      'amount': instance.amount,
      'amountDollars': instance.amountDollars,
      'price': instance.price,
      'fee': instance.fee,
      'date': instance.date.toIso8601String(),
      'profit': instance.profit,
      'userId': instance.userId,
    };
