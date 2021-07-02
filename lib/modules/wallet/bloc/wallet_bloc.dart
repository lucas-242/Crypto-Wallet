import 'package:crypto_wallet/repositories/cryptos_repository.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:flutter/foundation.dart';

import 'wallet_status.dart';

class WalletBloc extends ChangeNotifier {
  CryptosRepository _cryptosRepository;

  List<CryptoModel> cryptos = [];

  final statusNotifier = ValueNotifier<WalletStatus>(WalletStatus());

  WalletStatus get status => statusNotifier.value;
  set status(WalletStatus status) => statusNotifier.value = status;

  WalletBloc({required CryptosRepository cryptosRepository})
      : _cryptosRepository = cryptosRepository;

  Future<void> getCryptos(String uid) async {
    status = WalletStatus.loading();

    await _cryptosRepository.getAllCryptos(uid).then((value) {
      cryptos = value;
    }).catchError((error) {
      status = WalletStatus.error(error);
      print(error);
    });

    status = WalletStatus();
  }
}
