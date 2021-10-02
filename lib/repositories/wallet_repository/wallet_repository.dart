import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';

enum TradeCreateOption { create, update }
enum TradeDeleteOption { update, delete }

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

  /// Create a [trade] and create/update the related [crypto] considering [operation]
  Future<void> addTrade(
      TradeCreateOption operation, TradeModel trade, CryptoModel crypto) async {
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      if (operation == TradeCreateOption.create) {
        DocumentReference cryptosReference =
            FirebaseFirestore.instance.collection('cryptos').doc();
        transaction.set(cryptosReference, crypto.toMap());
      } else {
        DocumentReference cryptosReference =
            FirebaseFirestore.instance.collection('cryptos').doc(crypto.id);
        transaction.update(cryptosReference, crypto.toMap());
      }

      DocumentReference tradesReference =
          FirebaseFirestore.instance.collection('trades').doc();
      transaction.set(tradesReference, trade.toMap());
      print('tradeId: ' + tradesReference.id);
    });
  }

  /// Delete a [trade] and update/delete the related [crypto] considering [operation]
  Future<void> deleteTrade(
      TradeDeleteOption operation, TradeModel trade, CryptoModel crypto) async {
    DocumentReference tradesReference =
        FirebaseFirestore.instance.collection('trades').doc(trade.id);

    DocumentReference cryptosReference =
        FirebaseFirestore.instance.collection('cryptos').doc(crypto.id);

    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      if (operation == TradeDeleteOption.delete) {
        transaction.delete(cryptosReference);
      } else {
        transaction.update(cryptosReference, crypto.toMap());
      }

      transaction.delete(tradesReference);
    });
  }
}
