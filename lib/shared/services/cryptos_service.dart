import '/shared/helpers/wallet_helper.dart';
import '/shared/models/crypto_model.dart';
import '/shared/models/trade_model.dart';
import '../core/trade_type.dart';

/// This service is responsible for calculate the Crypto properties when creating or removing a trade
class CryptosService {
  /// Precision to calculate decimal numbers
  int _precision = 100000000;

  /// Calculate all [crypto] properties considering [trade] and all the [trades] before to calculate the Average Price.
  CryptoModel calculateCryptoProperties(CryptoModel crypto, TradeModel trade) {
    double amount = crypto.amount;
    double totalInvested = crypto.totalInvested;
    double averagePrice = crypto.averagePrice;
    double totalFee = crypto.totalFee;
    double totalProfit = crypto.totalProfit;

    if (trade.operationType == TradeType.buy) {
      amount += trade.amount;
      totalInvested += trade.amountDollars;
      totalFee += trade.fee;
      averagePrice = calculateAveragePrice(trade, crypto);
    }
    // !When selling the average price doesn't change
    else if (trade.operationType == TradeType.sell) {
      checkBalance(crypto, trade);
      amount -= trade.amount;
      totalInvested -= trade.amountDollars;
      totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;
      totalProfit += trade.amount * (trade.price - averagePrice);
      totalFee = amount <= 0 ? 0 : totalFee;
    }
    // !When transfering trades amount indicate the amount transfer to another wallet
    else {
      checkBalance(crypto, trade);
      amount -= trade.fee;
      totalInvested -= trade.amountDollars;
      totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;
    }

    crypto = crypto.copyWith(
      amount: amount,
      totalInvested: totalInvested,
      averagePrice: averagePrice,
      updatedAt: DateTime.now(),
      totalFee: totalFee,
      totalProfit: totalProfit,
      soldPositionAt: amount == 0
          ? trade.date
          : crypto.soldPositionAt != null
              ? crypto.soldPositionAt
              : null,
      lastTradeAt: trade.date,
      user: crypto.user,
    );

    return crypto;
  }

  /// Used to recalculate all the propreties of the [crypto] when deleting a [trade]
  /// considering all the [otherTrades]
  ///
  ///If [trade] would be null, only [otherTrades] will be consider to calculate properties
  CryptoModel recalculatingCryptoProperties(
    CryptoModel crypto,
    TradeModel? trade,
    List<TradeModel> otherTrades,
  ) {
    List<TradeModel> allTrades = [];
    allTrades.addAll(otherTrades);
    if (trade != null) allTrades.add(trade);
    allTrades.sort((a, b) => a.date.compareTo(b.date));

    TradeModel? soldPositionInThisTrade;
    var firstTradeAfterSoldPosition = false;

    crypto = setCrypto(
      crypto: crypto,
      amount: 0,
      averagePrice: 0,
      totalInvested: 0,
    );

    double totalProfit = 0;
    double totalFee = 0;
    double averagePrice = 0;
    DateTime? soldPositionAt = crypto.soldPositionAt;

    allTrades.forEach((element) {
      double amount = 0;
      double totalInvested = 0;

      if (element.operationType == TradeType.buy) {
        // *First Operation after sold all position
        if (!firstTradeAfterSoldPosition && soldPositionInThisTrade != null) {
          firstTradeAfterSoldPosition = true;
        }
        averagePrice = calculateAveragePrice(element, crypto);
        totalInvested = _sum(crypto.totalInvested, element.amountDollars);
        amount = _sum(crypto.amount, element.amount);
        totalFee += element.fee;
        crypto = setCrypto(
          crypto: crypto,
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
      // *When selling the average price and total fee don't change
      else if (element.operationType == TradeType.sell) {
        checkBalance(crypto, element);
        amount = _subtraction(crypto.amount, element.amount);
        totalInvested =
            _subtraction(crypto.totalInvested, element.amountDollars);
        totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;
        totalProfit +=
            element.amount * (_subtraction(element.price, crypto.averagePrice));

        if (amount == 0) {
          soldPositionAt = element.date;
          averagePrice = 0;
          totalFee = 0;
          soldPositionInThisTrade = element;
        }

        crypto = setCrypto(
          crypto: crypto,
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
      // *When transfering trades amount indicate the amount transfer to another wallet
      else {
        checkBalance(crypto, element);
        amount = _subtraction(crypto.amount, element.fee);
        totalInvested =
            _subtraction(crypto.totalInvested, element.amountDollars);
        totalInvested = totalInvested < 0 || amount == 0 ? 0 : totalInvested;

        if (amount == 0) {
          soldPositionAt = element.date;
          averagePrice = 0;
          totalFee = 0;
          soldPositionInThisTrade = element;
        }

        crypto = setCrypto(
          crypto: crypto,
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
    });

    crypto = crypto.copyWith(
      updatedAt: DateTime.now(),
      lastTradeAt: allTrades.last.date,
      soldPositionAt: soldPositionAt,
      totalFee: totalFee,
      totalProfit: totalProfit,
    );

    return crypto;
  }

  /// Calculate the average price considering all buying [trade] and the [totalAmount] on wallet
  double calculateAveragePrice(TradeModel trade, CryptoModel crypto) {
    var average = ((trade.price * trade.amount) +
            trade.fee +
            crypto.totalInvested +
            crypto.totalFee) /
        (crypto.amount + trade.amount);
    return average;
  }

  /// Copy the [crypto] setting the [amount], [averagePrice], [totalInvested] and [totalFee] properties
  CryptoModel setCrypto({
    required CryptoModel crypto,
    required double amount,
    required double averagePrice,
    required double totalInvested,
  }) {
    return crypto.copyWith(
      amount: amount,
      averagePrice: averagePrice,
      totalInvested: totalInvested,
    );
  }

  /// Create a [CryptoModel] considering a [trade]
  CryptoModel setCryptoForTheFirstTime(TradeModel trade) {
    var infos = WalletHelper.findCoin(trade.cryptoId);
    var crypto = CryptoModel(
      cryptoId: trade.cryptoId,
      name: infos.name,
      symbol: infos.symbol,
      amount: 0,
      averagePrice: 0,
      totalInvested: 0,
      user: trade.user!,
      lastTradeAt: trade.date,
    );

    var averagePrice = calculateAveragePrice(trade, crypto);
    crypto = crypto.copyWith(
      amount: trade.amount,
      averagePrice: averagePrice,
      totalInvested: trade.amountDollars,
      totalFee: trade.fee,
      updatedAt: DateTime.now(),
    );

    return crypto;
  }

  /// Check [crypto] balance based on [trade]
  void checkBalance(CryptoModel crypto, TradeModel trade) {
    //TODO: Validate Message
    if (!crypto.hasBalace(
      trade.operationType,
      trade.amount,
    )) {
      throw Exception('Não há saldo suficiente');
    }
  }

  /// Sum two numbers avoiding problems with precision
  double _sum(double value1, double value2) {
    final sum = (value1 * _precision).roundToDouble() +
        (value2 * _precision).roundToDouble();

    final result = sum / _precision;
    return result;
  }

  /// Subtract two numbers avoiding problems with precision
  double _subtraction(double value1, double value2) {
    final difference = (value1 * _precision).roundToDouble() -
        (value2 * _precision).roundToDouble();

    final result = difference / _precision;
    return result;
  }
}
