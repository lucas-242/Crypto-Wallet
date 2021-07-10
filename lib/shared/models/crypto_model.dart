import 'dart:convert';

class CryptoModel {
  final String? id;
  final String name;
  final String crypto;
  final double amount;
  final double averagePrice;
  final double totalInvested;
  final double price;
  final DateTime updatedAt;
  final String user;

  double get gainLoss => price * amount - totalInvested;

  CryptoModel({
    DateTime? updatedAt,
    this.id,
    this.name = '',
    required this.crypto,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    this.user = '',
    this.price = 0,
  }) : this.updatedAt = updatedAt ?? DateTime.now();

  CryptoModel copyWith({
    String? id,
    String? name,
    String? crypto,
    double? amount,
    double? averagePrice,
    double? totalInvested,
    double? price,
    DateTime? updatedAt,
    String? user,
  }) {
    return CryptoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      totalInvested: totalInvested ?? this.totalInvested,
      price: price ?? this.price,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'crypto': crypto,
      'amount': amount,
      'averagePrice': averagePrice,
      'totalInvested': totalInvested,
      'updatedAt': updatedAt,
      'user': user,
    };
  }

  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    return CryptoModel(
      id: map['id'],
      name: map['name'],
      crypto: map['crypto'],
      amount: map['amount'],
      averagePrice: map['averagePrice'],
      totalInvested: map['totalInvested'],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoModel.fromJson(String source) =>
      CryptoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CryptoModel(id: $id, name: $name, crypto: $crypto, amount: $amount, averagePrice: $averagePrice, totalInvested: $totalInvested, price: $price, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CryptoModel &&
        other.id == id &&
        other.name == name &&
        other.crypto == crypto &&
        other.amount == amount &&
        other.averagePrice == averagePrice &&
        other.totalInvested == totalInvested &&
        other.updatedAt == updatedAt &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        crypto.hashCode ^
        amount.hashCode ^
        averagePrice.hashCode ^
        totalInvested.hashCode ^
        updatedAt.hashCode ^
        user.hashCode;
  }
}
