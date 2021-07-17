import 'dart:convert';

class TradeModel {
  final String? id;
  final String operationType;
  final String crypto;
  final double amount;
  final double amountInvested;
  final double price;
  final double fee;
  final DateTime date;
  final String? user;

  TradeModel({
    this.id,
    required this.operationType,
    this.crypto = '',
    this.amount = 0,
    this.amountInvested = 0,
    this.price = 0,
    this.fee = 0,
    DateTime? date,
    this.user,
  }): this.date = date != null ? date : DateTime.now();

  TradeModel copyWith({
    String? id,
    String? operationType,
    String? crypto,
    double? amount,
    double? amountInvested,
    double? price,
    DateTime? date,
    double? fee,
    String? user,
  }) {
    return TradeModel(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      amountInvested: amountInvested ?? this.amountInvested,
      price: price ?? this.price,
      fee: fee ?? this.fee,
      date: date ?? this.date,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'operationType': operationType,
      'crypto': crypto,
      'amount': amount,
      'amountInvested': amountInvested,
      'price': price,
      'fee': fee,
      'date': date,
      'user': user,
    };
  }

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
      id: map['id'],
      operationType: map['operationType'],
      crypto: map['crypto'],
      amount: map['amount'],
      amountInvested: map['amountInvested'],
      price: map['price'],
      fee: map['fee'].toDouble(),
      date: DateTime.parse(map['date'].toDate().toString()),
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeModel.fromJson(String source) =>
      TradeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TradeModel(id: $id, operationType: $operationType, crypto: $crypto, amount: $amount, amountInvested: $amountInvested, price: $price, fee: $fee, date: $date, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TradeModel &&
        other.id == id &&
        other.operationType == operationType &&
        other.crypto == crypto &&
        other.amount == amount &&
        other.amountInvested == amountInvested &&
        other.price == price &&
        other.fee == fee &&
        other.date == date &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        operationType.hashCode ^
        crypto.hashCode ^
        amount.hashCode ^
        amountInvested.hashCode ^
        price.hashCode ^
        fee.hashCode ^
        date.hashCode ^
        user.hashCode;
  }
}
