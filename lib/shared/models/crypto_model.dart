import 'dart:convert';

class CryptoModel {

  final String crypto;
  final double amount;
  final double averagePrice;
  final double totalInvested;
  final double gainLoss;

  CryptoModel({
    required this.crypto,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    this.gainLoss = 0,
  });



  CryptoModel copyWith({
    String? crypto,
    double? amount,
    double? averagePrice,
    double? totalInvested,
    double? gainLoss,
  }) {
    return CryptoModel(
      crypto: crypto ?? this.crypto,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      totalInvested: totalInvested ?? this.totalInvested,
      gainLoss: gainLoss ?? this.gainLoss,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'crypto': crypto,
      'amount': amount,
      'averagePrice': averagePrice,
      'totalInvested': totalInvested,
      'gainLoss': gainLoss,
    };
  }

  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    return CryptoModel(
      crypto: map['crypto'],
      amount: map['amount'],
      averagePrice: map['averagePrice'],
      totalInvested: map['totalInvested'],
      gainLoss: map['gainLoss'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoModel.fromJson(String source) => CryptoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CryptoModel(crypto: $crypto, amount: $amount, averagePrice: $averagePrice, totalInvested: $totalInvested, gainLoss: $gainLoss)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CryptoModel &&
      other.crypto == crypto &&
      other.amount == amount &&
      other.averagePrice == averagePrice &&
      other.totalInvested == totalInvested &&
      other.gainLoss == gainLoss;
  }

  @override
  int get hashCode {
    return crypto.hashCode ^
      amount.hashCode ^
      averagePrice.hashCode ^
      totalInvested.hashCode ^
      gainLoss.hashCode;
  }
}
