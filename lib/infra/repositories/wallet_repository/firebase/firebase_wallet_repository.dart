import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/utils/log_utils.dart';
import 'package:crypto_wallet/domain/data/local_storage.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:crypto_wallet/domain/models/crypto.dart';
import 'package:crypto_wallet/domain/models/enums/trade_operartion.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/domain/repositories/wallet_repository.dart';

final class FirebaseWalletRepository implements WalletRepository {
  FirebaseWalletRepository({
    FirebaseFirestore? firestore,
    required LocalStorage localStorage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _localStorage = localStorage;
  final FirebaseFirestore _firestore;
  final LocalStorage _localStorage;

  //TODO: Check this
  String _getUser() =>
      AppUser.fromJson(jsonDecode(_localStorage.get<String>('user')!)).uid;

  @override
  Future<List<Crypto>> getCryptos() async {
    try {
      List<Crypto> result = [];

      await _firestore
          .collection('cryptos')
          .where('user', isEqualTo: _getUser)
          .where('amount', isGreaterThan: 0)
          .get()
          .then((QuerySnapshot querySnapshot) {
        result = querySnapshot.docs
            .map((e) => Crypto.fromJson(e.data() as dynamic))
            .toList();
        querySnapshot.docs.asMap().forEach((index, data) =>
            result[index] = result[index].copyWith(id: data.id));
      });

      return result;
    } on SocketException catch (error) {
      Log.error('No internet available to get cryptos: ${error.toString()}');
      throw NoConnectionError('No internet available');
    } catch (error) {
      Log.error('Error to get cryptos: ${error.toString()}');
      throw ExternalError('Error to get cryptos');
    }
  }

  @override
  Future<Crypto?> getCryptoById(String cryptoId) async {
    try {
      Crypto? result;

      await _firestore
          .collection('cryptos')
          .where('user', isEqualTo: _getUser)
          .where('cryptoId', isEqualTo: cryptoId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final data = querySnapshot.docs.first;
          result = Crypto.fromJson(data.data() as dynamic);
          result = result!.copyWith(id: data.id);
        }
      });

      return result;
    } on SocketException catch (error) {
      Log.error(
          'No internet available to get crypto $cryptoId: ${error.toString()}');
      throw NoConnectionError('No internet available');
    } catch (error) {
      Log.error('Error to get crypto $cryptoId: ${error.toString()}');
      throw ExternalError('Error to get crypto information');
    }
  }

  @override
  Future<List<Trade>> getTrades({String? cryptoId}) async {
    try {
      List<Trade> result = [];
      final query =
          _firestore.collection('trades').where('user', isEqualTo: _getUser);

      if (cryptoId != null) {
        query.where('cryptoId', isEqualTo: cryptoId);
      }

      query.orderBy('date');

      await query.get().then((QuerySnapshot querySnapshot) {
        result = querySnapshot.docs
            .map((e) => Trade.fromJson(e.data() as dynamic))
            .toList();
        querySnapshot.docs.asMap().forEach((index, data) =>
            result[index] = result[index].copyWith(id: data.id));
      });

      return result;
    } on SocketException catch (error) {
      Log.error('No internet available to get trades: ${error.toString()}');
      throw NoConnectionError('No internet available');
    } catch (error) {
      Log.error('Error to get trades: ${error.toString()}');
      throw ExternalError('Error to get trades');
    }
  }

  @override
  Future<void> addTrade(
      TradeCreateOperation operation, Trade trade, Crypto crypto) async {
    try {
      return await _firestore.runTransaction((transaction) async {
        if (operation == TradeCreateOperation.create) {
          final DocumentReference cryptosReference =
              _firestore.collection('cryptos').doc();
          transaction.set(cryptosReference, crypto.toJson());
        } else {
          final DocumentReference cryptosReference =
              _firestore.collection('cryptos').doc(crypto.id);
          transaction.update(cryptosReference, crypto.toJson());
        }

        final DocumentReference tradesReference =
            _firestore.collection('trades').doc();
        transaction.set(tradesReference, trade.toJson());
      });
    } on SocketException catch (error) {
      Log.error('No internet available to add trade: ${error.toString()}');
      throw NoConnectionError('No internet available');
    } catch (error) {
      Log.error('Error to add trade: ${error.toString()}');
      throw ExternalError('Error to add trade');
    }
  }

  @override
  Future<void> deleteTrade(
      TradeDeleteOperation operation, Trade trade, Crypto crypto) async {
    try {
      final DocumentReference tradesReference =
          _firestore.collection('trades').doc(trade.id);

      final DocumentReference cryptosReference =
          _firestore.collection('cryptos').doc(crypto.id);

      return await _firestore.runTransaction((transaction) async {
        if (operation == TradeDeleteOperation.delete) {
          transaction.delete(cryptosReference);
        } else {
          transaction.update(cryptosReference, crypto.toJson());
        }

        transaction.delete(tradesReference);
      });
    } on SocketException catch (error) {
      Log.error('No internet available to delete trade: ${error.toString()}');
      throw NoConnectionError('No internet available');
    } catch (error) {
      Log.error('Error to delete trade: ${error.toString()}');
      throw ExternalError('Error to delete trade');
    }
  }
}
