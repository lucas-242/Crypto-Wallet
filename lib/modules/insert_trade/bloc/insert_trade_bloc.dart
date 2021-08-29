import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/helpers/ad_helper.dart';
import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/dropdown_item_model.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'insert_trade_status.dart';

class InsertTradeBloc extends ChangeNotifier {
  WalletRepository _walletRepository;
  late InterstitialAd _interstitialAd;

  final formKey = GlobalKey<FormState>();
  TradeModel trade = TradeModel();

  final statusNotifier = ValueNotifier<InsertTradeStatus>(InsertTradeStatus());

  late AppLocalizations appLocalizations;

  InsertTradeStatus get status => statusNotifier.value;
  set status(InsertTradeStatus status) => statusNotifier.value = status;

  InsertTradeBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository;

  String? validateCrypto(DropdownItem? value) {
    return value == null ? appLocalizations.errorFieldNull : null;
  }

  String? validateCryptoAmount(String? value) {
    return value == null ||
            double.parse(value.replaceAll(RegExp(','), '.')) == 0
        ? appLocalizations.errorFieldNull
        : null;
  }

  String? validateTradedAmount(String? value) {
    if (value != null) {
      //Remove $, . from the middle of the number and change , to .
      value = value
          .substring(1)
          .replaceAll(RegExp(r'\.'), '')
          .replaceAll(RegExp(','), '.');

      return double.parse(value) < 0 ? appLocalizations.errorFieldNull : null;
    }

    return null;
  }

  String? validateDate(String? value) {
    return value == null || value.length != 10
        ? appLocalizations.errorFieldWrongDate
        : null;
  }

  String? validateTradePrice(String? value) {
    if (value != null) {
      //Remove $, . from the middle of the number and change , to .
      value = value
          .substring(1)
          .replaceAll(RegExp(r'\.'), '')
          .replaceAll(RegExp(','), '.');

      return double.parse(value) < 0
          ? appLocalizations.errorFieldTradePrice
          : null;
    }

    return null;
  }

  void onChange({
    String? operationType,
    String? crypto,
    double? amount,
    double? ammountInvested,
    double? price,
    double? fee,
    String? date,
    String? user,
  }) {
    DateTime? formattedDate;

    if (date != null && date.length == 10) {
      var split = date.split(RegExp(r'[^\w\s]+'));
      formattedDate = DateTime(
          int.parse(split[2]), int.parse(split[1]), int.parse(split[0]));
    }

    trade = trade.copyWith(
      operationType: operationType,
      amount: amount,
      amountInvested: ammountInvested,
      crypto: crypto,
      date: formattedDate,
      price: price,
      fee: fee,
      user: user,
    );
  }

  Future<void> addTrade({
    required WalletBloc walletBloc,
    required TradesBloc tradesBloc,
    required String uid,
  }) async {
    final form = formKey.currentState;

    if (!form!.validate()) throw Exception('Invalid form');

    status = InsertTradeStatus.loading();

    var cryptos = await _walletRepository.getAllCryptos(uid);
    _validateAmount(cryptos);

    if (_interstitialAd.responseInfo != null) _interstitialAd.show();

    return await _walletRepository.addTrade(cryptos, trade).then((value) {
      tradesBloc.getTrades(uid);
      walletBloc.getCryptos(uid);
      trade = TradeModel(user: uid);
      status = InsertTradeStatus();
    }).catchError((error) {
      status = InsertTradeStatus.error(error.toString());
    });
  }

  ///Verify if the user has enough amount in [cryptos] to create a selling trade
  void _validateAmount(List<CryptoModel> cryptos) {
    if (trade.operationType == TradeType.sell) {
      var found = cryptos.where((c) => c.crypto == trade.crypto);
      if (found.isEmpty || found.first.amount < trade.amount) {
        var error = appLocalizations.errorInsufficientBalance;
        status = InsertTradeStatus.error(error);
        throw Exception(error);
      }
    }
  }

  ///Load the InterstitialAd
  loadAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _interstitialAd.fullScreenContentCallback =
                FullScreenContentCallback(
              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void dispose() {
    statusNotifier.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }
}
