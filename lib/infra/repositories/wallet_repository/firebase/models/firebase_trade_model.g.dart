// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_trade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseTradeModel _$FirebaseTradeModelFromJson(Map<String, dynamic> json) =>
    FirebaseTradeModel(
      cryptoId: json['cryptoId'] as String,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      amountDollars: (json['amountDollars'] as num?)?.toDouble() ?? 0,
      cryptoSymbol: json['cryptoSymbol'] as String,
      date: FirebaseTradeModel._dateFromJson(json['date'] as Timestamp),
      fee: (json['fee'] as num?)?.toDouble() ?? 0,
      operationType: json['operationType'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      profit: (json['profit'] as num?)?.toDouble() ?? 0,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$FirebaseTradeModelToJson(FirebaseTradeModel instance) =>
    <String, dynamic>{
      'operationType': instance.operationType,
      'cryptoSymbol': instance.cryptoSymbol,
      'cryptoId': instance.cryptoId,
      'amount': instance.amount,
      'amountDollars': instance.amountDollars,
      'price': instance.price,
      'fee': instance.fee,
      'profit': instance.profit,
      'user': instance.user,
      'date': FirebaseTradeModel._dateToJson(instance.date),
    };
