import 'package:crypto_wallet/domain/models/crypto.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_crypto.g.dart';

@JsonSerializable()
class WalletCrypto {
  WalletCrypto({
    required this.id,
    required this.cryptoId,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    this.percentInWallet = 0,
    this.userId = '',
    this.totalFee = 0,
    this.totalProfit = 0,
    this.soldPositionAt,
    this.marketData,
    DateTime? lastTradeAt,
    DateTime? updatedAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        lastTradeAt = lastTradeAt ?? DateTime.now();

  factory WalletCrypto.fromJson(Map<String, dynamic> json) =>
      _$WalletCryptoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletCryptoToJson(this);

  final String? id;
  final String cryptoId;
  final double amount;
  final double averagePrice;
  final double totalInvested;
  final DateTime updatedAt;

//TODO: Remove it
  final double percentInWallet;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Crypto? marketData;

  /// Date when the user sold all position in the crypto
  final DateTime? soldPositionAt;

  /// The newest Trade Date
  final DateTime lastTradeAt;

  /// Total fee in dollars in buy trades. Used to calculate average price easily.
  final double totalFee;

  /// Total profit in dollars in sell trades. Used to show to the user easily.
  final double totalProfit;

  @JsonKey(name: 'user')
  final String userId;

  /// Total amount at current quote of selected currency
  double get totalNow => marketData?.currentPrice ?? 0 * amount;

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
    String? cryptoId,
    double? amount,
    double? averagePrice,
    double? totalInvested,
    DateTime? updatedAt,
    DateTime? soldPositionAt,
    DateTime? lastTradeAt,
    double? totalFee,
    double? totalProfit,
    String? userId,
    Crypto? marketData,
  }) {
    return WalletCrypto(
      id: id ?? this.id,
      cryptoId: cryptoId ?? this.cryptoId,
      amount: amount ?? this.amount,
      averagePrice: averagePrice ?? this.averagePrice,
      totalInvested: totalInvested ?? this.totalInvested,
      updatedAt: updatedAt ?? this.updatedAt,
      soldPositionAt: soldPositionAt ?? this.soldPositionAt,
      lastTradeAt: lastTradeAt ?? this.lastTradeAt,
      totalFee: totalFee ?? this.totalFee,
      totalProfit: totalProfit ?? this.totalProfit,
      userId: userId ?? this.userId,
      marketData: marketData ?? this.marketData,
    );
  }
}
