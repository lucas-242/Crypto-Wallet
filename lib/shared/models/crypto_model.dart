import 'dart:convert';

import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/models/crypto_history_model.dart';

class CryptoModel {
  final String? id;
  final String name;
  final String? image;
  final String symbol;
  final String cryptoId;
  final double amount;
  final double averagePrice;
  final double totalInvested;
  final double price;
  final DateTime updatedAt;

  /// Date when the user sold all position in the crypto
  final DateTime? soldPositionAt;

  /// The newest Trade Date
  final DateTime lastTradeAt;
  
  /// Total fee in buy trades. Used to calculate average price more easily.
  final double totalFee;
  
  final String user;
  final CryptoHistory? history;

  /// Total amount at current quote of selected currency
  double get totalNow => price * amount;

  double get gainLoss => totalNow - totalInvested - totalFee;

  double get gainLossPercent => (gainLoss * 100 / totalNow) / 100;

  ///Verify if has enough balance to selling or transfer
  bool hasBalace(
    String operationType,
    double amountToCheck,
  ) {
    if (operationType == TradeType.sell ||
        operationType == TradeType.transfer) {
      if (amount < amountToCheck) return false;
    }
    return true;
  }

  // void prepareToTrade(
  //   String operationType,
  //   double tradeAmount,
  //   double tradeAmountDollars,
  //   double tradeFee,
  // ) {
  //   double newAmount = amount;
  //   double newTotalInvested = totalInvested;
  //   double newAveragePrice = averagePrice;

  //   if (operationType == TradeType.buy) {
  //     newAmount = amount + tradeAmount;
  //     newTotalInvested = totalInvested + tradeAmountDollars;
  //     newAveragePrice = calculateAveragePrice1(trade, crypto);
  //   }
  //   // !When selling the average price doesn't change
  //   else if (operationType == TradeType.sell) {
  //     newAmount = amount - tradeAmount;
  //     newTotalInvested = totalInvested - tradeAmountDollars;
  //     newTotalInvested = totalInvested < 0 ? 0 : totalInvested;
  //   }
  //   // !When transfering trades amount indicate the amount transfer to another wallet
  //   else {
  //     newAmount = amount - tradeFee;
  //     newTotalInvested = totalInvested - tradeAmountDollars;
  //     newTotalInvested = totalInvested < 0 ? 0 : totalInvested;
  //   }

  //   copyWith(
  //     amount: newAmount,
  //     totalInvested: newTotalInvested,
  //     averagePrice: newAveragePrice,
  //     updatedAt: DateTime.now(),
  //     user: user,
  //   );
  // }

  CryptoModel({
    DateTime? updatedAt,
    this.id,
    this.name = '',
    this.image,
    required this.symbol,
    required this.cryptoId,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    this.user = '',
    this.price = 0,
    this.history,
    this.totalFee = 0,
    this.soldPositionAt,
    DateTime? lastTradeAt,
  })  : this.updatedAt = updatedAt ?? DateTime.now(),
        this.lastTradeAt = lastTradeAt ?? DateTime.now();

  CryptoModel copyWith({
    String? id,
    String? name,
    String? image,
    String? crypto,
    String? cryptoId,
    double? amount,
    double? averagePrice,
    double? totalInvested,
    double? price,
    DateTime? updatedAt,
    String? user,
    CryptoHistory? history,
    double? totalFee,
    DateTime? soldPositionAt,
    DateTime? lastTradeAt,
  }) {
    return CryptoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      symbol: crypto ?? this.symbol,
      cryptoId: cryptoId ?? this.cryptoId,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      totalInvested: totalInvested ?? this.totalInvested,
      price: price ?? this.price,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      history: history ?? this.history,
      totalFee: totalFee ?? this.totalFee,
      soldPositionAt: soldPositionAt ?? this.soldPositionAt,
      lastTradeAt: lastTradeAt ?? this.lastTradeAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cryptoId': cryptoId,
      'symbol': symbol,
      'amount': amount,
      'averagePrice': averagePrice,
      'totalInvested': totalInvested,
      'updatedAt': updatedAt,
      'user': user,
      'totalFee': totalFee,
      'soldPositionAt': soldPositionAt,
      'lastTradeAt': lastTradeAt,
    };
  }

  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    return CryptoModel(
      id: map['id'],
      name: map['name'],
      symbol: map['symbol'],
      cryptoId: map['cryptoId'],
      // * These converts are used to prevent the following error: "type 'int' is not a subtype of type 'double'"
      amount: double.tryParse(map['amount'].toString()) ?? 0,
      averagePrice: double.tryParse(map['averagePrice'].toString()) ?? 0,
      totalInvested: double.tryParse(map['totalInvested'].toString()) ?? 0,
      totalFee: double.tryParse(map['totalFee'].toString()) ?? 0,
      updatedAt: DateTime.parse(map['updatedAt'].toDate().toString()),
      user: map['user'],
      soldPositionAt: DateTime.parse(map['soldPositionAt'].toDate().toString()),
      lastTradeAt: DateTime.parse(map['lastTradeAt'].toDate().toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoModel.fromJson(String source) =>
      CryptoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CryptoModel(id: $id, name: $name, symbol: $symbol, amount: $amount, averagePrice: $averagePrice, totalInvested: $totalInvested, price: $price, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CryptoModel &&
        other.id == id &&
        other.name == name &&
        other.symbol == symbol &&
        other.cryptoId == cryptoId &&
        other.amount == amount &&
        other.averagePrice == averagePrice &&
        other.totalInvested == totalInvested &&
        other.updatedAt == updatedAt &&
        other.totalFee == totalFee &&
        other.soldPositionAt == soldPositionAt &&
        other.lastTradeAt == lastTradeAt &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        cryptoId.hashCode ^
        amount.hashCode ^
        averagePrice.hashCode ^
        totalInvested.hashCode ^
        updatedAt.hashCode ^
        totalFee.hashCode ^
        soldPositionAt.hashCode ^
        lastTradeAt.hashCode ^
        user.hashCode;
  }
}
