import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firebase_trade_model.g.dart';

@JsonSerializable()
final class FirebaseTradeModel {
  FirebaseTradeModel({
    this.id,
    required this.cryptoId,
    this.amount = 0,
    this.amountDollars = 0,
    required this.cryptoSymbol,
    required this.date,
    this.fee = 0,
    required this.operationType,
    this.price = 0,
    this.profit = 0,
    required this.user,
  });

  factory FirebaseTradeModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseTradeModelFromJson(json);

  factory FirebaseTradeModel.fromWalletCrypto(Trade trade) =>
      FirebaseTradeModel(
        id: trade.id,
        cryptoId: trade.cryptoId,
        amount: trade.amount,
        amountDollars: trade.amountDollars,
        cryptoSymbol: trade.cryptoSymbol,
        date: trade.date,
        fee: trade.fee,
        operationType: trade.operationType,
        price: trade.price,
        profit: trade.profit,
        user: trade.userId,
      );

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  final String operationType;
  final String cryptoSymbol;
  final String cryptoId;
  final double amount;
  final double amountDollars;
  final double price;
  final double fee;
  final double profit;
  final String? user;

  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime date;

  static Timestamp? _dateToJson(DateTime? value) =>
      value != null ? Timestamp.fromDate(value) : null;

  static DateTime _dateFromJson(Timestamp value) => value.toDate();

  Map<String, dynamic> toJson() => _$FirebaseTradeModelToJson(this);

  Trade toTrade() => Trade(
        id: id,
        cryptoId: cryptoId,
        amount: amount,
        amountDollars: amountDollars,
        cryptoSymbol: cryptoSymbol,
        date: date,
        fee: fee,
        operationType: operationType,
        price: price,
        profit: profit,
        userId: user,
      );
}
