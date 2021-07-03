import 'package:crypto_wallet/repositories/wallet_repository.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:flutter/foundation.dart';

import 'wallet_status.dart';

class WalletBloc extends ChangeNotifier {
  WalletRepository _walletRepository;

  List<CryptoModel> cryptos = [];

  final statusNotifier = ValueNotifier<WalletStatus>(WalletStatus());

  WalletStatus get status => statusNotifier.value;
  set status(WalletStatus status) => statusNotifier.value = status;

  WalletBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository;

  Future<void> getCryptos(String uid) async {
    status = WalletStatus.loading();

    await _walletRepository.getAllCryptos(uid).then((value) {
      cryptos = value;
    }).catchError((error) {
      status = WalletStatus.error(error);
      print(error);
    });

    if (cryptos.isEmpty) {
      status = WalletStatus.noData();
    } else {
      status = WalletStatus();
    }
    notifyListeners();
  }

  void updateCrypto(CryptoModel model) {
    var index = cryptos.indexWhere((element) => element.crypto == model.crypto);

    if (index == -1) {
      cryptos.add(model);
    } else {
      cryptos[index] = model;
    }

    notifyListeners();
  }
}
