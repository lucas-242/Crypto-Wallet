import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/helpers/crypto_helper.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';

class WalletRepository {

  ///Fetch for all user's cryptos
  ///
  ///[uid] refers to the user's identification
  Future<List<CryptoModel>> getCryptos(String uid) async {
    try {
      List<CryptoModel> result = [];

      await FirebaseFirestore.instance
          .collection('cryptos')
          .where('user', isEqualTo: uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        result = querySnapshot.docs
            .map((e) => CryptoModel.fromMap(e.data() as dynamic))
            .toList();
        querySnapshot.docs.asMap().forEach((index, data) =>
            result[index] = result[index].copyWith(id: data.id));
      });

      return result;
    } catch (error) {
      print('Error while getting data on cryptos: ${error.toString()}');
      throw new Exception(error.toString());
    }
  }

  ///Fetch for an user's crypto 
  ///
  ///[uid] refers to the user's identification
  ///
  ///[cryptoId] refers to the crypto's cryptoId property
  Future<CryptoModel?> getCryptoById(String uid, String cryptoId) async {
    try {
      CryptoModel? result;

      await FirebaseFirestore.instance
          .collection('cryptos')
          .where('user', isEqualTo: uid)
          .where('cryptoId', isEqualTo: cryptoId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.length >= 1) {
          var data = querySnapshot.docs.first;
          result = CryptoModel.fromMap(data.data() as dynamic);
          result = result!.copyWith(id: data.id);
        }
      });

      return result;
    } catch (error) {
      print('Error while getting data on cryptos: ${error.toString()}');
      throw new Exception(error.toString());
    }
  }

  ///Fetch for all user's trades considering user's [uid]
  ///
  ///[cryptoId] refers to the Trade's cryptoId and can be used as a filter
  Future<List<TradeModel>> getTrades(String uid, {String? cryptoId}) async {
    try {
      List<TradeModel> result = [];
      Query<Map<String, dynamic>> query;

      if (cryptoId != null) {
        query = FirebaseFirestore.instance
            .collection('trades')
            .where('user', isEqualTo: uid)
            .where('cryptoId', isEqualTo: cryptoId)
            .orderBy('date');
      } else {
        query = FirebaseFirestore.instance
            .collection('trades')
            .where('user', isEqualTo: uid)
            .orderBy('date');
      }

      await query.get().then((QuerySnapshot querySnapshot) {
        result = querySnapshot.docs
            .map((e) => TradeModel.fromMap(e.data() as dynamic))
            .toList();
        querySnapshot.docs.asMap().forEach((index, data) =>
            result[index] = result[index].copyWith(id: data.id));
      });

      return result;
    } catch (error) {
      print('Error while getting data on trades: ${error.toString()}');
      throw new Exception(
          'Error while getting data on trades: ${error.toString()}');
    }
  }

  /// Add a [trade]
  Future<void> addTrade(TradeModel trade) async {
    var crypto = await getCryptoById(trade.user!, trade.cryptoId);

    // Adding crypto for the first time
    if (crypto == null) {
      if (trade.operationType != TradeType.buy)
        throw Exception('Não há saldo suficiente');

      DocumentReference tradesReference =
          FirebaseFirestore.instance.collection('trades').doc();

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        _createCryptoInTransaction(transaction, trade);
        transaction.set(tradesReference, trade.toMap());
        print('tradeId: ' + tradesReference.id);
      });
    }
    // Had crypto previously
    else {
      late CryptoModel updatedCrypto;

      //Check if the type of trade to set some properties
      trade = _setTrade(trade, crypto.averagePrice);

      //If this trade is before the last one or if it is the first trade after sold all position
      if ((trade.date.compareTo(crypto.lastTradeAt) < 0) ||
          (crypto.soldPositionAt != null && crypto.amount == 0)) {
        var otherTrades =
            await getTrades(trade.user!, cryptoId: trade.cryptoId);
        updatedCrypto =
            recalculatingCryptoProperties(crypto, trade, otherTrades);
      } else {
        updatedCrypto = calculateCryptoProperties(crypto, trade);
      }

      DocumentReference tradesReference =
          FirebaseFirestore.instance.collection('trades').doc();

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        _updateCryptoInTransaction(transaction, updatedCrypto);
        transaction.set(tradesReference, trade.toMap());
        print('tradeId: ' + tradesReference.id);
      });
    }
  }

  /// Delete a [trade]
  Future<void> deleteTrade(TradeModel trade) async {
    DocumentReference tradesReference =
        FirebaseFirestore.instance.collection('trades').doc(trade.id);

    var crypto = await getCryptoById(trade.user!, trade.cryptoId);

    if (crypto == null) return;

    var allTrades = await getTrades(trade.user!, cryptoId: trade.cryptoId);

    // Delete trade and crypto if this trade is the only one in the wallet
    if (allTrades.length == 1) {
      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        _deleteCryptoInTransaction(transaction, crypto);
        transaction.delete(tradesReference);
      });
    }

    var otherTrades = allTrades.where((element) => element != trade).toList();
    var updatedCrypto =
        recalculatingCryptoProperties(crypto, null, otherTrades);

    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      _updateCryptoInTransaction(transaction, updatedCrypto);
      transaction.delete(tradesReference);
    });
  }

  /// Create a crypto inside a [transaction] using a [trade] as reference
  void _createCryptoInTransaction(Transaction transaction, TradeModel trade) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc();

    var trades = <TradeModel>[];
    trades.add(trade);

    var infos = CryptoHelper.findCoin(trade.cryptoId);
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

    var averagePrice = _calculateAveragePrice(trade, crypto);
    crypto = crypto.copyWith(
      amount: trade.amount,
      averagePrice: averagePrice,
      totalInvested: trade.amountDollars,
      totalFee: trade.fee * trade.price,
      updatedAt: DateTime.now(),
    );

    transaction.set(cryptosReference, crypto.toMap());

    print('transaction created:  $crypto');
  }

  /// Update a [crypto] inside a [transaction]
  void _updateCryptoInTransaction(Transaction transaction, CryptoModel crypto) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc(crypto.id);

    transaction.update(cryptosReference, crypto.toMap());
    print('transaction updated:  $crypto');
  }

  /// Delete a [crypto] inside a [transaction]
  void _deleteCryptoInTransaction(Transaction transaction, CryptoModel crypto) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc(crypto.id);

    transaction.delete(cryptosReference);
    print('transaction deleted:  $crypto');
  }

  /// Calculate all [crypto] properties considering [trade] and all the [trades] before to calculate the Average Price.
  CryptoModel calculateCryptoProperties(CryptoModel crypto, TradeModel trade) {
    double amount = crypto.amount;
    double totalInvested = crypto.totalInvested;
    double averagePrice = crypto.averagePrice;
    double totalFee = crypto.totalFee;
    double totalProfit = crypto.totalProfit;

    //TODO: Decidir se o fee será descontado do amount ou se o usuário já irá informar descontado
    if (trade.operationType == TradeType.buy) {
      amount += trade.amount;
      totalInvested += trade.amountDollars;
      totalFee += trade.fee * trade.price;
      averagePrice = _calculateAveragePrice(trade, crypto);
    }
    // !When selling the average price doesn't change
    else if (trade.operationType == TradeType.sell) {
      _checkBalance(crypto, trade);
      amount -= trade.amount;
      totalInvested -= trade.amountDollars;
      totalInvested = totalInvested < 0 ? 0 : totalInvested;
      totalProfit += trade.amount * (trade.price - averagePrice);
      totalFee = amount <= 0 ? 0 : totalFee;
    }
    // !When transfering trades amount indicate the amount transfer to another wallet
    else {
      _checkBalance(crypto, trade);
      amount -= trade.fee;
      totalInvested -= trade.amountDollars;
      totalInvested = totalInvested < 0 ? 0 : totalInvested;
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

    crypto = _setCrypto(
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
        averagePrice = _calculateAveragePrice(element, crypto);
        totalInvested = crypto.totalInvested + element.amountDollars;
        amount = crypto.amount + element.amount;
        totalFee += (element.price * element.fee);
        crypto = _setCrypto(
          crypto: crypto,
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
      // *When selling the average price and total fee don't change
      else if (element.operationType == TradeType.sell) {
        _checkBalance(crypto, element);
        totalInvested = crypto.totalInvested - element.amountDollars;
        totalInvested = totalInvested < 0 ? 0 : totalInvested;
        amount = crypto.amount - element.amount;
        totalProfit += element.amount * (element.price - crypto.averagePrice);

        if (amount == 0) {
          soldPositionAt = element.date;
          averagePrice = 0;
          totalFee = 0;
          soldPositionInThisTrade = element;
        }

        crypto = _setCrypto(
          crypto: crypto,
          amount: amount,
          averagePrice: averagePrice,
          totalInvested: totalInvested,
        );
      }
      // *When transfering trades amount indicate the amount transfer to another wallet
      else {
        _checkBalance(crypto, element);
        totalInvested = crypto.totalInvested - element.amountDollars;
        totalInvested = totalInvested < 0 ? 0 : totalInvested;
        amount = crypto.amount - element.fee;

        if (amount == 0) {
          soldPositionAt = element.date;
          averagePrice = 0;
          totalFee = 0;
          soldPositionInThisTrade = element;
        }

        crypto = _setCrypto(
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
  double _calculateAveragePrice(TradeModel trade, CryptoModel crypto) {
    var average = ((trade.price * trade.amount) +
            (trade.price * trade.fee) +
            crypto.totalInvested +
            crypto.totalFee) /
        (crypto.amount + trade.amount);
    return average;
  }

  /// Copy the [crypto] setting the [amount], [averagePrice], [totalInvested] and [totalFee] properties
  CryptoModel _setCrypto({
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

  /// Set [trade] profit, price and amount dollars according to the operation type and the crypto [averagePrice]
  ///
  /// When transfering, the trade price is the average price, and the Amount in Dollars is calculated using the fee
  TradeModel _setTrade(TradeModel trade, double averagePrice) {
    if (trade.operationType == TradeType.transfer) {
      trade = trade.copyWith(
        price: averagePrice,
        amountDollars: averagePrice * trade.fee,
      );

      return trade;
    } else if (trade.operationType == TradeType.sell) {
      trade = trade.copyWith(
        profit: trade.amount * (trade.price - averagePrice),
      );

      return trade;
    }

    return trade;
  }

  /// Check [crypto] balance based on [trade]
  void _checkBalance(CryptoModel crypto, TradeModel trade) {
    //TODO: Decidir se o fee será descontado do amount ou se o usuário já irá informar descontado
    if (!crypto.hasBalace(
      trade.operationType,
      trade.operationType == TradeType.transfer
          ? trade.fee + trade.amount
          : trade.amount,
    )) {
      throw Exception('Não há saldo suficiente');
    }
  }
}
