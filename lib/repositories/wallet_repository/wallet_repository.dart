import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/models/crypto_info_model.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:flutter/widgets.dart';

class WalletRepository {
  List<CryptoInfoModel> cryptoList = [];

  ///Fetch all crytpo infos from the data file
  void getAllCryptoInfos(BuildContext context) async {
    if (cryptoList.isEmpty) {
      var source = await DefaultAssetBundle.of(context)
          .loadString('assets/data/cryptos.json');
      var decoded = json.decode(source) as List<dynamic>;
      cryptoList = decoded.map((e) => CryptoInfoModel.fromMap(e)).toList();
    }
  }

  ///Fetch for all user's cryptos
  Future<List<CryptoModel>> getAllCryptos(String uid) async {
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
  Future<List<TradeModel>> getAllTrades(
      {required String uid, String? crypto}) async {
    try {
      List<TradeModel> result = [];

      await FirebaseFirestore.instance
          .collection('trades')
          .where('user', isEqualTo: uid)
          .where('crypto', isEqualTo: crypto)
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
      var trades = await getAllTrades(uid: trade.user!, crypto: trade.crypto);
      trades.add(trade);

      late CryptoModel crypto;

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        transaction.set(tradesReference, trade.toMap());

        cryptos =
            cryptos.where((element) => element.crypto == trade.crypto).toList();
        if (cryptos.isEmpty) {
          _createCryptoInTransaction(transaction, trade);
        } else {
          crypto = _calculateCryptoProperties(cryptos.single, trades, trade);
          _updateCryptoInTransaction(transaction, crypto);
        }
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

        _updateCryptoInTransaction(transaction, crypto);

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

    var crypto = CryptoModel(
      id: Cryptos.apiIds[trade.crypto]!,
      name: Cryptos.names[trade.crypto]!,
      crypto: trade.crypto,
      amount: trade.amount,
      averagePrice: averagePrice,
      totalInvested: trade.amountInvested,
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
    double amount = 0;
    double totalInvested = 0;
    double averagePrice = crypto.averagePrice;

    if (trade.operationType == TradeType.buy) {
      amount = crypto.amount + trade.amount;
      totalInvested = crypto.totalInvested + trade.amountInvested;
      averagePrice = _calculateAveragePrice(trades, amount);
    }
    // !When selling the average price doesn't change
    else {
      amount = crypto.amount - trade.amount;
      totalInvested = crypto.totalInvested - trade.amountInvested;
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
        totalInvested += element.amountInvested;
        amount += element.amount;
      } else {
        totalInvested -= element.amountInvested;
        amount -= element.amount;
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

  /// Calculate the average price considering all [trades] and the [totalAmount] on wallet
  double _calculateAveragePrice(List<TradeModel> trades, double totalAmount) {
    var sum = 0.0;
    trades.forEach((element) => sum = sum +
        ((element.price * element.amount) + (element.price * element.fee)));
    var averagePrice = sum / totalAmount;
    return averagePrice;
  }
}
