import 'package:crypto_wallet/domain/models/crypto_history.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';

class Crypto {
  Crypto({
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
    this.totalProfit = 0,
    this.soldPositionAt,
    DateTime? lastTradeAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        lastTradeAt = lastTradeAt ?? DateTime.now();

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
}
