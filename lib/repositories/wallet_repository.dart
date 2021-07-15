import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/models/trade_type.dart';

class WalletRepository {
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
  Future<List<TradeModel>> getAllTrades(String uid) async {
    try {
      List<TradeModel> result = [];

      await FirebaseFirestore.instance
          .collection('trades')
          .where('user', isEqualTo: uid)
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
      throw new Exception(error.toString());
    }
  }

  Future<void> addTrade(List<CryptoModel> cryptos, TradeModel trade) async {
    try {
      DocumentReference tradesReference =
          FirebaseFirestore.instance.collection('trades').doc();

      late CryptoModel crypto;

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        transaction.set(tradesReference, trade.toMap());

        cryptos =
            cryptos.where((element) => element.crypto == trade.crypto).toList();
        if (cryptos.isEmpty) {
          _createCryptoInTransaction(transaction, trade);
        } else {
          crypto = _calculateCryptoMetrics(cryptos.single, trade);
          _updateCryptoInTransaction(transaction, crypto);
        }
      });
    } catch (error) {
      print("Failed to add trade: ${error.toString()}");
      throw new Exception(error.toString());
    }
  }

  Future<void> deleteTrade(CryptoModel crypto, TradeModel trade) async {
    try {
      DocumentReference tradesReference =
          FirebaseFirestore.instance.collection('trades').doc(trade.id);

      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        crypto = _calculateCryptoMetrics(
          crypto,
          trade.copyWith(operationType: TradeType.SELL),
        );
        if (crypto.totalInvested == 0) {
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

    var crypto = CryptoModel(
      name: Cryptos.MAP[trade.crypto]!,
      crypto: trade.crypto,
      amount: trade.amount,
      averagePrice: trade.price,
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

  CryptoModel _calculateCryptoMetrics(CryptoModel crypto, TradeModel trade) {
    var updatedDate = DateTime.now();
    if (trade.operationType == TradeType.BUY) {
      var amount = crypto.amount + trade.amount;
      var totalInvested = crypto.totalInvested + trade.amountInvested;

      crypto = crypto.copyWith(
        amount: amount,
        totalInvested: totalInvested,
        averagePrice: totalInvested / amount,
        updatedAt: updatedDate,
        user: crypto.user,
      );
    } else {
      var amount = crypto.amount - trade.amount;
      var totalInvested = crypto.totalInvested - trade.amountInvested;

      crypto = crypto.copyWith(
        amount: amount,
        totalInvested: totalInvested,
        averagePrice: totalInvested / amount,
        updatedAt: updatedDate,
        user: crypto.user,
      );
    }

    return crypto;
  }
}
