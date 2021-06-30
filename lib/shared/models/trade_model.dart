import 'dart:convert';

class TradeModel {
  final String? operationType;
  final String? crypto;
  final double? amount;
  final double? price;
  final DateTime? date;
  final String? user;
  TradeModel({
    this.operationType,
    this.crypto,
    this.amount,
    this.price,
    this.date,
    this.user,
  });


  TradeModel copyWith({
    String? operationType,
    String? crypto,
    double? amount,
    double? price,
    DateTime? date,
    String? user,
  }) {
    return TradeModel(
      operationType: operationType ?? this.operationType,
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      date: date ?? this.date,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'operationType': operationType,
      'crypto': crypto,
      'amount': amount,
      'price': price,
      'date': date,
      'user': user
    };
  }

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
      operationType: map['operationType'],
      crypto: map['crypto'],
      amount: map['amount'],
      price: map['price'],
      user: map['user'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeModel.fromJson(String source) => TradeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Trade(operationType: $operationType, crypto: $crypto, amount: $amount, price: $price, date: $date, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TradeModel &&
      other.operationType == operationType &&
      other.crypto == crypto &&
      other.amount == amount &&
      other.price == price &&
      other.date == date &&
      other.user == user;
  }

  @override
  int get hashCode {
    return operationType.hashCode ^
      crypto.hashCode ^
      amount.hashCode ^
      price.hashCode ^
      user.hashCode ^
      date.hashCode;
  }
}
