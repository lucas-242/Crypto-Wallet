import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';

class CryptosRepository {
  final _collection = 'cryptos';

  Future<List<CryptoModel>> getAllCryptos(String uid) async {
    List<CryptoModel> result = [];

    await FirebaseFirestore.instance
        .collection(_collection)
        .where('user', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        //TODO: use fromJson method
        result.add(CryptoModel(
            crypto: element['crypto'],
            amount: element['amount'],
            averagePrice: element['averagePrice'],
            totalInvested: element['totalInvested'],
            updatedAt: element['updatedAt']));
      });
    }).catchError((error) {
      print('Erro while getting data on $_collection: $error');
    });

    return result;
  }
}
