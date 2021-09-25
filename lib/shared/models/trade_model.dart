import 'dart:convert';

class TradeModel {
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

  ///Fee in the same coin type
  final double fee;
  final DateTime date;
  /// If it is a sell trade, it can have a profit
  final double profit;
  final String? user;

  TradeModel({
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
  }) : this.date = date != null ? date : DateTime.now();

  TradeModel copyWith({
    String? id,
    String? operationType,
    String? cryptoSymbol,
    String? cryptoId,
    double? amount,
    double? amountDollars,
    double? price,
    DateTime? date,
    double? fee,
    double? profit,
    String? user,
  }) {
    return TradeModel(
      id: id ?? this.id,
      cryptoSymbol: cryptoSymbol ?? this.cryptoSymbol,
      cryptoId: cryptoId ?? this.cryptoId,
      operationType: operationType ?? this.operationType,
      amount: amount ?? this.amount,
      amountDollars: amountDollars ?? this.amountDollars,
      price: price ?? this.price,
      fee: fee ?? this.fee,
      date: date ?? this.date,
      profit: profit ?? this.profit,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'operationType': operationType,
      'cryptoSymbol': cryptoSymbol,
      'cryptoId': cryptoId,
      'amount': amount,
      'amountDollars': amountDollars,
      'price': price,
      'fee': fee,
      'date': date,
      'profit': profit,
      'user': user,
    };
  }

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
      id: map['id'],
      cryptoId: map['cryptoId'],
      cryptoSymbol: map['cryptoSymbol'],
      operationType: map['operationType'],
      amount: map['amount'].toDouble(),
      amountDollars: map['amountDollars'].toDouble(),
      price: map['price'],
      fee: map['fee'].toDouble(),
      profit:  map['profit'] != null ? map['profit'].toDouble() : 0,
      date: DateTime.parse(map['date'].toDate().toString()),
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeModel.fromJson(String source) =>
      TradeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TradeModel(id: $id, operationType: $operationType, amount: $amount, amountDollars: $amountDollars, price: $price, fee: $fee, date: $date, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TradeModel &&
        other.id == id &&
        other.cryptoId == cryptoId &&
        other.cryptoSymbol == cryptoSymbol &&
        other.operationType == operationType &&
        other.amount == amount &&
        other.amountDollars == amountDollars &&
        other.price == price &&
        other.fee == fee &&
        other.date == date &&
        other.profit == profit &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cryptoId.hashCode ^
        cryptoSymbol.hashCode ^
        operationType.hashCode ^
        amount.hashCode ^
        amountDollars.hashCode ^
        price.hashCode ^
        fee.hashCode ^
        date.hashCode ^
        profit.hashCode ^
        user.hashCode;
  }
}
