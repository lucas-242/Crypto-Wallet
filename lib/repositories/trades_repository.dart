import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';

class TradesRepository {
  final _collection = 'trades';

  Future<List<TradeModel>> getAllTrades(String uid) async {
    List<TradeModel> result = [];

    await FirebaseFirestore.instance
        .collection(_collection)
        .where('user', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        //TODO: use fromJson method
        result.add(TradeModel(
          amount: element['amount'],
          crypto: element['crypto'],
          date: DateTime.parse(element['date'].toDate().toString()),
          operationType: element['operationType'],
          price: element['price'],
          user: element['user'],
        ));
      });
    }).catchError((error) {
      print('Erro while getting data on $_collection: $error');
    });

    print(result);
    return result;
  }

  Future<TradeModel?> addTrade(TradeModel model) async {
    return await FirebaseFirestore.instance
        .collection(_collection)
        .add(model.toMap())
        .then((value) => model)
        .catchError((error) {
      print(error);
      return null;
    });
  }
}
