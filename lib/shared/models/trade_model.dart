import 'dart:convert';

class Trade {
  final String? operationType;
  final String? crypto;
  final double? amount;
  final double? price;
  final DateTime? date;
  Trade({
    this.operationType,
    this.crypto,
    this.amount,
    this.price,
    this.date,
  });


  Trade copyWith({
    String? operationType,
    String? crypto,
    double? amount,
    double? price,
    DateTime? date,
  }) {
    return Trade(
      operationType: operationType ?? this.operationType,
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'operationType': operationType,
      'crypto': crypto,
      'amount': amount,
      'price': price,
      'date': date,
    };
  }

  factory Trade.fromMap(Map<String, dynamic> map) {
    return Trade(
      operationType: map['operationType'],
      crypto: map['crypto'],
      amount: map['amount'],
      price: map['price'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trade.fromJson(String source) => Trade.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Trade(operationType: $operationType, crypto: $crypto, amount: $amount, price: $price, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Trade &&
      other.operationType == operationType &&
      other.crypto == crypto &&
      other.amount == amount &&
      other.price == price &&
      other.date == date;
  }

  @override
  int get hashCode {
    return operationType.hashCode ^
      crypto.hashCode ^
      amount.hashCode ^
      price.hashCode ^
      date.hashCode;
  }
}
