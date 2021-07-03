import 'dart:convert';

class CryptoModel {
  final String? id;
  final String crypto;
  final double amount;
  final double averagePrice;
  final double totalInvested;
  final double gainLoss;
  final DateTime updatedAt;
  final String user;

  CryptoModel({
    DateTime? updatedAt,
    this.id,
    required this.crypto,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    this.user = '',
    this.gainLoss = 0,
  }) : this.updatedAt = updatedAt ?? DateTime.now();

  CryptoModel copyWith({
    String? id,
    String? crypto,
    double? amount,
    double? averagePrice,
    double? totalInvested,
    double? gainLoss,
    DateTime? updatedAt,
    String? user,
  }) {
    return CryptoModel(
      id: id ?? this.id,
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      totalInvested: totalInvested ?? this.totalInvested,
      gainLoss: gainLoss ?? this.gainLoss,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
      crypto: map['crypto'],
      amount: map['amount'],
      averagePrice: map['averagePrice'],
      totalInvested: map['totalInvested'],
      gainLoss: map['gainLoss'],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoModel.fromJson(String source) =>
      CryptoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CryptoModel(id: $id, crypto: $crypto, amount: $amount, averagePrice: $averagePrice, totalInvested: $totalInvested, gainLoss: $gainLoss, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CryptoModel &&
        other.id == id &&
        other.crypto == crypto &&
        other.amount == amount &&
        other.averagePrice == averagePrice &&
        other.totalInvested == totalInvested &&
        other.gainLoss == gainLoss &&
        other.updatedAt == updatedAt &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        crypto.hashCode ^
        amount.hashCode ^
        averagePrice.hashCode ^
        totalInvested.hashCode ^
        gainLoss.hashCode ^
        updatedAt.hashCode ^
        user.hashCode;
  }
}
