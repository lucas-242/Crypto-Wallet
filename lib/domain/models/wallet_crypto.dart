import 'package:crypto_wallet/domain/models/crypto.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:equatable/equatable.dart';

final class WalletCrypto extends Equatable {
  WalletCrypto({
    required this.id,
    required this.cryptoId,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    this.userId = '',
    this.totalFee = 0,
    this.totalProfit = 0,
    this.soldPositionAt,
    this.marketData,
    this.isOpen = false,
    DateTime? lastTradeAt,
    DateTime? updatedAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        lastTradeAt = lastTradeAt ?? DateTime.now();

  final String? id;
  final String cryptoId;
  final double amount;
  final double averagePrice;
  final double totalInvested;
  final DateTime updatedAt;

  /// Date when the user sold all position in the crypto
  final DateTime? soldPositionAt;

  /// The newest Trade Date
  final DateTime lastTradeAt;

  /// Total fee in dollars in buy trades. Used to calculate average price easily.
  final double totalFee;

  /// Total profit in dollars in sell trades. Used to show to the user easily.
  final double totalProfit;

  final String userId;

  ///Crypto market data
  final Crypto? marketData;

  ///Flag if an crypto card is open in the wallet page
  final bool isOpen;

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
    bool? isOpen,
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
      isOpen: isOpen ?? this.isOpen,
    );
  }

  @override
  List<Object?> get props => [
        id,
        cryptoId,
        amount,
        averagePrice,
        totalInvested,
        updatedAt,
        soldPositionAt,
        lastTradeAt,
        totalFee,
        totalProfit,
        userId,
        marketData,
        isOpen,
      ];
}
