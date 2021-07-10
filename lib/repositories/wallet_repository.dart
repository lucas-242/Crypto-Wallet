import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/models/trade_type.dart';

class WalletRepository {
  Future<List<CryptoModel>> getAllCryptos(String uid) async {
    List<CryptoModel> result = [];

    await FirebaseFirestore.instance
        .collection('cryptos')
        .where('user', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        //TODO: use fromJson method
        result.add(CryptoModel(
          id: element.id,
          name: element['name'],
          crypto: element['crypto'],
          amount: element['amount'],
          averagePrice: element['averagePrice'],
          totalInvested: element['totalInvested'],
          updatedAt: DateTime.parse(element['updatedAt'].toDate().toString()),
        ));
      });
    }).catchError((error) {
      print('Error while getting data on cryptos: $error');
    });

    return result;
  }

  Future<List<TradeModel>> getAllTrades(String uid) async {
    List<TradeModel> result = [];

    await FirebaseFirestore.instance
        .collection('trades')
        .where('user', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs
          .map((e) => TradeModel.fromMap(e.data() as dynamic))
          .toList();

      //TODO:find a better way to fill the ids
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        result[i] = result[i].copyWith(id: querySnapshot.docs[i].id);
      }
      // querySnapshot.docs.forEach((element) {
      //   result.add(TradeModel(
      //     id: element.id,
      //     amount: element['amount'],
      //     crypto: element['crypto'],
      //     date: DateTime.parse(element['date'].toDate().toString()),
      //     operationType: element['operationType'],
      //     price: element['price'],
      //     user: element['user'],
      //   ));
      // });
    }).catchError((error) {
      print('Error while getting data on trades: $error');
    });

    return result;
  }

  Future<Map<String, dynamic>?> addTrade(
      List<CryptoModel> cryptos, TradeModel trade) async {
    DocumentReference tradesReference =
        FirebaseFirestore.instance.collection('trades').doc();

    late CryptoModel crypto;

    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(tradesReference, trade.toMap());

      cryptos =
          cryptos.where((element) => element.crypto == trade.crypto).toList();
      if (cryptos.isEmpty) {
        crypto = createCrypto(transaction, trade);
      } else {
        crypto = _calculateCryptoMetrics(cryptos.single, trade);
        updateCrypto(transaction, crypto);
      }
    }).then((value) {
      print(value);
      //TODO: Fill trade and crypto with Id if it's possible
      return {'trade': trade, 'crypto': crypto};
    }).catchError((error) {
      print("Failed to add trade: $error");
    });
  }

  CryptoModel createCrypto(Transaction transaction, TradeModel trade) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc();

    var crypto = CryptoModel(
      name: Cryptos.MAP[trade.crypto!]!,
      crypto: trade.crypto!,
      amount: trade.amount!,
      averagePrice: trade.price!,
      totalInvested: trade.amountInvested!,
      user:
          trade.user!, //TODO: the property user from CryptoModel is empty here
      updatedAt: DateTime.now(),
    );

    transaction.set(cryptosReference, crypto.toMap());

    print('transaction created:  $crypto');

    return crypto;
  }

  void updateCrypto(Transaction transaction, CryptoModel crypto) {
    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc(crypto.id);

    transaction.update(cryptosReference, crypto.toMap());
    print('transaction updated:  $crypto');
  }

//TODO: ERROR TO DELETE TRADE
  Future<void> deleteTrade(List<CryptoModel> cryptos, TradeModel trade) async {
    DocumentReference tradesReference =
        FirebaseFirestore.instance.collection('trades').doc(trade.id);

    late CryptoModel crypto;

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      crypto = _calculateCryptoMetrics(
        cryptos.single,
        trade.copyWith(operationType: TradeType.SELL),
      );
      updateCrypto(transaction, crypto);
      transaction.delete(tradesReference);
    }).then((value) {
      print(value);
    }).catchError((error) {
      print("Failed to delete trade: $error");
    });
  }

  CryptoModel _calculateCryptoMetrics(CryptoModel crypto, TradeModel trade) {
    var updatedDate = DateTime.now();
    if (trade.operationType == TradeType.BUY) {
      var amount = crypto.amount + trade.amount!;
      var totalInvested = crypto.totalInvested + trade.amountInvested!;

      crypto = crypto.copyWith(
        amount: amount,
        totalInvested: totalInvested,
        averagePrice: totalInvested / amount,
        updatedAt: updatedDate,
        user:
            trade.user, //TODO: the property user from CryptoModel is empty here
      );
    } else {
      var amount = crypto.amount - trade.amount!;
      var totalInvested = crypto.totalInvested - trade.amountInvested!;

      crypto = crypto.copyWith(
        amount: amount,
        totalInvested: totalInvested,
        averagePrice: totalInvested / amount,
        updatedAt: updatedDate,
        user:
            trade.user, //TODO: the property user from CryptoModel is empty here
      );
    }

    return crypto;
  }
}
