import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_crypto.g.dart';

@JsonSerializable()
class WalletCrypto {
  WalletCrypto({
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
    this.totalFee = 0,
    this.totalProfit = 0,
    this.soldPositionAt,
    DateTime? lastTradeAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        lastTradeAt = lastTradeAt ?? DateTime.now();

  factory WalletCrypto.fromJson(Map<String, dynamic> json) =>
      _$WalletCryptoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletCryptoToJson(this);

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

  /// Total fee in dollars in buy trades. Used to calculate average price easily.
  final double totalFee;

  /// Total profit in dollars in sell trades. Used to show to the user easily.
  final double totalProfit;

  final String user;

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

  WalletCrypto copyWith({
    String? id,
    String? name,
    String? image,
    String? symbol,
    String? cryptoId,
    double? amount,
    double? averagePrice,
    double? totalInvested,
    double? price,
    DateTime? updatedAt,
    DateTime? soldPositionAt,
    DateTime? lastTradeAt,
    double? totalFee,
    double? totalProfit,
    String? user,
  }) {
    return WalletCrypto(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      symbol: symbol ?? this.symbol,
      cryptoId: cryptoId ?? this.cryptoId,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      totalInvested: totalInvested ?? this.totalInvested,
      price: price ?? this.price,
      updatedAt: updatedAt ?? this.updatedAt,
      soldPositionAt: soldPositionAt ?? this.soldPositionAt,
      lastTradeAt: lastTradeAt ?? this.lastTradeAt,
      totalFee: totalFee ?? this.totalFee,
      totalProfit: totalProfit ?? this.totalProfit,
      user: user ?? this.user,
    );
  }
}
