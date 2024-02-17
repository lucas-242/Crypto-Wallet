import 'package:crypto_wallet/core/extensions/double_extensions.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/domain/services/cryptos_services.dart';
import 'package:http/http.dart';

final class LocalCryptosService implements CryptosService {
  @override
  WalletCrypto setCryptoByOperation(WalletCrypto crypto, Trade trade) {
    double amount = crypto.amount;
    double totalInvested = crypto.totalInvested;
    double averagePrice = crypto.averagePrice;
    double totalFee = crypto.totalFee;
    double totalProfit = crypto.totalProfit;

    switch (trade.operationType) {
      case TradeType.buy:
        {
          amount += trade.amount;
          totalInvested += trade.amountDollars;
          totalFee += trade.fee;
          averagePrice = _calculateAveragePrice(trade, crypto);
        }
        break;
      // !When selling the average price doesn't change
      case TradeType.sell:
        {
          _checkBalance(crypto, trade);
          amount -= trade.amount;
          totalInvested -= trade.amountDollars;
          totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;
          totalProfit += trade.amount * (trade.price - averagePrice);
          totalFee = amount <= 0 ? 0 : totalFee;
        }
        break;
      // !When transfering trades amount indicate the amount transfer to another wallet
      default:
        {
          _checkBalance(crypto, trade);
          amount -= trade.fee;
          totalInvested -= trade.amountDollars;
          totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;
        }
        break;
    }

    crypto = crypto.copyWith(
      amount: amount,
      totalInvested: totalInvested,
      averagePrice: averagePrice,
      updatedAt: DateTime.now(),
      totalFee: totalFee,
      totalProfit: totalProfit,
      soldPositionAt: amount == 0 ? trade.date : crypto.soldPositionAt,
      lastTradeAt: trade.date,
      userId: crypto.userId,
    );

    return crypto;
  }

  /// Calculate the average price considering [trade] and the [crypto] data
  double _calculateAveragePrice(Trade trade, WalletCrypto crypto) =>
      ((trade.price * trade.amount) +
          trade.fee +
          crypto.totalInvested +
          crypto.totalFee) /
      (crypto.amount + trade.amount);

  /// Check [crypto] balance based on [trade]
  void _checkBalance(WalletCrypto crypto, Trade trade) {
    if (!crypto.hasBalance(
      trade.operationType,
      trade.amount,
    )) {
      throw ClientException(AppLocalizations.current.errorInsufficientBalance);
    }
  }

  @override
  WalletCrypto recalculatingWalletCrypto({
    required WalletCrypto crypto,
    required List<Trade> trades,
    Trade? trade,
  }) {
    final List<Trade> allTrades = [];
    allTrades.addAll(trades);
    if (trade != null) allTrades.add(trade);
    allTrades.sort((a, b) => a.date.compareTo(b.date));

    Trade? soldPositionInThisTrade;
    var firstTradeAfterSoldPosition = false;

    crypto = crypto.copyWith(
      amount: 0,
      averagePrice: 0,
      totalInvested: 0,
    );

    double totalProfit = 0;
    double totalFee = 0;
    double averagePrice = 0;
    DateTime? soldPositionAt = crypto.soldPositionAt;

    for (var element in allTrades) {
      double amount = 0;
      double totalInvested = 0;

      if (element.operationType == TradeType.buy) {
        // *First Operation after sold all position
        if (!firstTradeAfterSoldPosition && soldPositionInThisTrade != null) {
          firstTradeAfterSoldPosition = true;
        }
        averagePrice = _calculateAveragePrice(element, crypto);
        totalInvested = crypto.totalInvested.sum(element.amountDollars);
        amount = crypto.amount.sum(element.amount);
        totalFee += element.fee;
        crypto = crypto.copyWith(
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
      // *When selling the average price and total fee don't change
      else if (element.operationType == TradeType.sell) {
        _checkBalance(crypto, element);
        amount = crypto.amount.sub(element.amount);
        totalInvested = crypto.totalInvested.sub(element.amountDollars);
        totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;
        totalProfit +=
            element.amount * (element.price.sub(crypto.averagePrice));

        if (amount == 0) {
          soldPositionAt = element.date;
          averagePrice = 0;
          totalFee = 0;
          soldPositionInThisTrade = element;
        }

        crypto = crypto.copyWith(
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
      // *When transfering trades amount indicate the amount transfer to another wallet
      else {
        _checkBalance(crypto, element);
        amount = crypto.amount.sub(element.fee);
        totalInvested = crypto.totalInvested.sub(element.amountDollars);
        totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;

        if (amount == 0) {
          soldPositionAt = element.date;
          averagePrice = 0;
          totalFee = 0;
          soldPositionInThisTrade = element;
        }

        crypto = crypto.copyWith(
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
    }

    crypto = crypto.copyWith(
      updatedAt: DateTime.now(),
      lastTradeAt: allTrades.last.date,
      soldPositionAt: soldPositionAt,
      totalFee: totalFee,
      totalProfit: totalProfit,
    );

    return crypto;
  }
}
