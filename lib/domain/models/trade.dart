import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trade.g.dart';

@JsonSerializable()
final class Trade extends Equatable {
  Trade({
    this.id = '',
    this.operationType = '',
    this.cryptoSymbol = '',
    this.cryptoId = '',
    this.amount = 0,
    this.amountDollars = 0,
    this.price = 0,
    this.fee = 0,
    this.profit = 0,
    DateTime? date,
    this.userId,
  }) : date = date ?? DateTime.now();

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);

  Map<String, dynamic> toJson() => _$TradeToJson(this);

  final String id;
  final String operationType;
  final String cryptoSymbol;
  final String cryptoId;

  ///Amount traded in coin Type
  final double amount;

  ///Amount traded in USD
  final double amountDollars;

  ///Coin price in USD
  final double price;

  ///Fee in USD
  final double fee;
  final DateTime date;

  /// If it is a sell trade, it can have a profit
  final double profit;
  final String? userId;

  @override
  List<Object?> get props => [
        id,
        operationType,
        cryptoSymbol,
        cryptoId,
        amount,
        amountDollars,
        price,
        fee,
        date,
        profit,
        userId,
      ];

  Trade copyWith({
    String? id,
    String? operationType,
    String? cryptoSymbol,
    String? cryptoId,
    double? amount,
    double? amountDollars,
    double? price,
    double? fee,
    DateTime? date,
    double? profit,
    String? user,
  }) {
    return Trade(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      cryptoSymbol: cryptoSymbol ?? this.cryptoSymbol,
      cryptoId: cryptoId ?? this.cryptoId,
      amount: amount ?? this.amount,
      amountDollars: amountDollars ?? this.amountDollars,
      price: price ?? this.price,
      fee: fee ?? this.fee,
      date: date ?? this.date,
      profit: profit ?? this.profit,
      userId: user ?? userId,
    );
  }

  /// Set [trade] profit, price and amount dollars according to the operation type and the crypto [averagePrice]
  ///
  /// When transfering, the trade price is the average price, and the Amount in Dollars is calculated using the fee

  Trade setTrade(double averagePrice) {
    if (operationType == TradeType.transfer) {
      return copyWith(
        price: averagePrice,
        amountDollars: fee,
      );
    }

    if (operationType == TradeType.sell) {
      return copyWith(
        profit: amount * (price - averagePrice),
      );
    }

    return this;
  }
}
