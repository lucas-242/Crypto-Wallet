import 'dart:convert';

class TradeModel {
  final String? operationType;
  final String? crypto;
  final double? amount;
  final double? price;
  final DateTime? date;
  TradeModel({
    this.operationType,
    this.crypto,
    this.amount,
    this.price,
    this.date,
  });


  TradeModel copyWith({
    String? operationType,
    String? crypto,
    double? amount,
    double? price,
    DateTime? date,
  }) {
    return TradeModel(
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

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
      operationType: map['operationType'],
      crypto: map['crypto'],
      amount: map['amount'],
      price: map['price'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeModel.fromJson(String source) => TradeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Trade(operationType: $operationType, crypto: $crypto, amount: $amount, price: $price, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TradeModel &&
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
