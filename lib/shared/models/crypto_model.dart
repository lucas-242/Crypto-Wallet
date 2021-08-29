import 'dart:convert';

import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/models/crypto_history_model.dart';

class CryptoModel {
  final String id;
  final String name;
  final String? image;
  final String crypto;
  final double amount;
  final double averagePrice;
  final double totalInvested;
  final double price;
  final DateTime updatedAt;
  final String user;
  final CryptoHistory? history;

  /// Total amount at current quote of selected currency
  double get totalNow => price * amount;

  double get gainLoss => totalNow - totalInvested;

  double get gainLossPercent => (gainLoss * 100 / totalNow) / 100;

  CryptoModel({
    DateTime? updatedAt,
    required this.id,
    this.name = '',
    this.image,
    required this.crypto,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    this.user = '',
    this.price = 0,
    this.history,
  }) : this.updatedAt = updatedAt ?? DateTime.now();

  CryptoModel copyWith({
    String? id,
    String? name,
    String? image,
    String? crypto,
    double? amount,
    double? averagePrice,
    double? totalInvested,
    double? price,
    DateTime? updatedAt,
    String? user,
    CryptoHistory? history,
  }) {
    return CryptoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      totalInvested: totalInvested ?? this.totalInvested,
      price: price ?? this.price,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      id: map['id'] ?? Cryptos.apiIds[map['crypto']],
      name: map['name'],
      crypto: map['crypto'],
      // * These converts are used to prevent the following error: "type 'int' is not a subtype of type 'double'"
      amount: double.tryParse(map['amount'].toString()) ?? 0,
      averagePrice: double.tryParse(map['averagePrice'].toString()) ?? 0,
      totalInvested: double.tryParse(map['totalInvested'].toString()) ?? 0,
      updatedAt: DateTime.parse(map['updatedAt'].toDate().toString()),
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
