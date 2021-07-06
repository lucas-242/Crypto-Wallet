import 'dart:convert';

class TradeModel {
  final String? id;
  final String? operationType;
  final String? crypto;
  final double? amount;
  final double? amountInvested;
  final double? price;
  final DateTime? date;
  final String? user;

  TradeModel({
    this.id,
    this.operationType,
    this.crypto,
    this.amount,
    this.amountInvested,
    this.price,
    this.date,
    this.user,
  });

  TradeModel copyWith({
    String? id,
    String? operationType,
    String? crypto,
    double? amount,
    double? amountInvested,
    double? price,
    DateTime? date,
    String? user,
  }) {
    return TradeModel(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      amountInvested: amountInvested ?? this.amountInvested,
      price: price ?? this.price,
      date: date ?? this.date,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'operationType': operationType,
      'crypto': crypto,
      'amount': amount,
      'amountInvested': amountInvested,
      'price': price,
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
      date: DateTime.parse(map['date'].toDate().toString()),
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeModel.fromJson(String source) =>
      TradeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TradeModel(id: $id, operationType: $operationType, crypto: $crypto, amount: $amount, amountInvested: $amountInvested, price: $price, date: $date, user: $user)';
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
        date.hashCode ^
        user.hashCode;
  }
}
