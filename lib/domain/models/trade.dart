import 'package:equatable/equatable.dart';

class Trade extends Equatable {
  Trade({
    this.id,
    this.operationType = '',
    this.cryptoSymbol = '',
    this.cryptoId = '',
    this.amount = 0,
    this.amountDollars = 0,
    this.price = 0,
    this.fee = 0,
    this.profit = 0,
    DateTime? date,
    this.user,
  }) : date = date ?? DateTime.now();

  final String? id;
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
  final String? user;

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
        user,
      ];
}
