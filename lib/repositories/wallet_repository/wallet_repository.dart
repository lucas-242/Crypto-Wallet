import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/helpers/crypto_helper.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';

class WalletRepository {
  ///Fetch for all user's cryptos
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

  ///Fetch for all user's trades
  Future<List<TradeModel>> getTrades(
      {required String uid, String? cryptoId}) async {
    try {
      List<TradeModel> result = [];

      await FirebaseFirestore.instance
          .collection('trades')
          .where('user', isEqualTo: uid)
          .where('cryptoId', isEqualTo: cryptoId)
          .get()
          .then((QuerySnapshot querySnapshot) {
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

  /// Add a [trade] considering [cryptos] to verify if need update or create a new Crypto on database
  Future<void> addTrade(List<CryptoModel> cryptos, TradeModel trade) async {
    try {
      DocumentReference tradesReference =
          FirebaseFirestore.instance.collection('trades').doc();

      //Get all trades of the same crypto
      var trades = await getTrades(uid: trade.user!, cryptoId: trade.cryptoId);

      //Get only the cryptos where id is equal of the trade id
      cryptos = cryptos
          .where((element) => element.cryptoId == trade.cryptoId)
          .toList();

      // !When transfering the trade price is the average price and the Amount in Dollars is calculated
      if (trade.operationType == TradeType.transfer && cryptos.isNotEmpty) {
        var crypto = cryptos.single;
        var amountDollars = crypto.averagePrice * trade.fee;
        trade = trade.copyWith(
            price: crypto.averagePrice, amountDollars: amountDollars);
      }

      trades.add(trade);

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        if (cryptos.isEmpty) {
          _createCryptoInTransaction(transaction, trade);
        } else {
          var crypto =
              _calculateCryptoProperties(cryptos.single, trades, trade);
          // Delete it from wallet if the user no longer has the crypto
          if (crypto.amount == 0) {
            _deleteCryptoInTransaction(transaction, crypto);
          } else {
            _updateCryptoInTransaction(transaction, crypto);
          }
        }

        transaction.set(tradesReference, trade.toMap());
      });
    } catch (error) {
      print("Failed to add trade: ${error.toString()}");
      throw new Exception("Failed to add trade: ${error.toString()}");
    }
  }

  /// Delete a [trade] of a [crypto] considering the other [trades] to recalculate the Average Price
  Future<void> deleteTrade(
      CryptoModel crypto, List<TradeModel> trades, TradeModel trade) async {
    try {
      DocumentReference tradesReference =
          FirebaseFirestore.instance.collection('trades').doc(trade.id);

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        if (trades.length == 0) {
          _deleteCryptoInTransaction(transaction, crypto);
          transaction.delete(tradesReference);
          return;
        }
        crypto = _recalculateCryptoProperties(
          crypto,
          trades,
          trade,
        );

        // Delete it from wallet if the user no longer has the crypto
        if (crypto.amount == 0) {
          _deleteCryptoInTransaction(transaction, crypto);
        } else {
          _updateCryptoInTransaction(transaction, crypto);
        }

        transaction.delete(tradesReference);
      });
    } catch (error) {
      print("Failed to delete trade: ${error.toString()}");
      throw new Exception("Failed to delete trade: ${error.toString()}");
    }
  }

  void _createCryptoInTransaction(Transaction transaction, TradeModel trade) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc();

    var trades = <TradeModel>[];
    trades.add(trade);
    var averagePrice = _calculateAveragePrice(trades, trade.amount);

    var infos = CryptoHelper.findCoin(trade.cryptoId);
    var crypto = CryptoModel(
      cryptoId: trade.cryptoId,
      name: infos.name,
      symbol: infos.symbol,
      amount: trade.amount,
      averagePrice: averagePrice,
      totalInvested: trade.amountDollars,
      user: trade.user!,
      updatedAt: DateTime.now(),
    );

    transaction.set(cryptosReference, crypto.toMap());

    print('transaction created:  $crypto');
  }

  void _updateCryptoInTransaction(Transaction transaction, CryptoModel crypto) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc(crypto.id);

    transaction.update(cryptosReference, crypto.toMap());
    print('transaction updated:  $crypto');
  }

  void _deleteCryptoInTransaction(Transaction transaction, CryptoModel crypto) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc(crypto.id);

    transaction.delete(cryptosReference);
    print('transaction deleted:  $crypto');
  }

  /// Calculate all [crypto] properties considering [trade] and all the [trades] to calculate the Average Price.
  CryptoModel _calculateCryptoProperties(
      CryptoModel crypto, List<TradeModel> trades, TradeModel trade) {
    double amount = crypto.amount;
    double totalInvested = crypto.totalInvested;
    double averagePrice = crypto.averagePrice;

    if (trade.operationType == TradeType.buy) {
      amount = crypto.amount + trade.amount;
      totalInvested = crypto.totalInvested + trade.amountDollars;
      averagePrice = _calculateAveragePrice(trades, amount);
    }
    // !When selling the average price doesn't change
    else if (trade.operationType == TradeType.sell) {
      amount = crypto.amount - trade.amount;
      totalInvested = crypto.totalInvested - trade.amountDollars;
      totalInvested = totalInvested < 0 ? 0 : totalInvested;
    }
    // !When transfering trades amount indicate the amount transfer to another wallet
    else {
      amount = crypto.amount - trade.fee;
      totalInvested = crypto.totalInvested - trade.amountDollars;
      totalInvested = totalInvested < 0 ? 0 : totalInvested;
    }

    crypto = crypto.copyWith(
      amount: amount,
      totalInvested: totalInvested,
      averagePrice: averagePrice,
      updatedAt: DateTime.now(),
      user: crypto.user,
    );

    return crypto;
  }

  /// Used to recalculate all the propreties of the [crypto] when deleting a [trade]
  /// considering all the other [trades]
  CryptoModel _recalculateCryptoProperties(
    CryptoModel crypto,
    List<TradeModel> trades,
    TradeModel trade,
  ) {
    double amount = 0;
    double totalInvested = 0;
    double averagePrice = 0;

    trades.forEach((element) {
      if (element.operationType == TradeType.buy) {
        totalInvested += element.amountDollars;
        amount += element.amount;
      } else if (element.operationType == TradeType.sell) {
        totalInvested -= element.amountDollars;
        amount -= element.amount;
      } else {
        totalInvested -= element.amountDollars;
        amount -= element.fee;
      }
    });

    amount = amount < 0 ? 0 : amount;
    totalInvested = totalInvested < 0 ? 0 : totalInvested;

    if (amount > 0) {
      averagePrice = _calculateAveragePrice(trades, amount);
    }

    crypto = crypto.copyWith(
      amount: amount,
      averagePrice: averagePrice,
      totalInvested: totalInvested,
      updatedAt: DateTime.now(),
    );

    return crypto;
  }

  /// Calculate the average price considering all buying [trades] and the [totalAmount] on wallet
  double _calculateAveragePrice(List<TradeModel> trades, double totalAmount) {
    var sum = 0.0;
    trades.forEach((trade) {
      if (trade.operationType == TradeType.buy)
        sum = sum + ((trade.price * trade.amount) + (trade.price * trade.fee));
    });
    var averagePrice = sum / totalAmount;
    return averagePrice;
  }
}
