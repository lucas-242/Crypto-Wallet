import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/blocs/wallet/wallet.dart';
import '/modules/trades/trades.dart';
import '/repositories/wallet_repository/wallet_repository.dart';
import '../../../shared/core/trade_type.dart';
import '/shared/helpers/ad_helper.dart';
import '/shared/helpers/wallet_helper.dart';
import '/shared/models/crypto_model.dart';
import '/shared/models/dropdown_item_model.dart';
import '/shared/models/trade_model.dart';
import '/shared/services/cryptos_service.dart';

import 'insert_trade_status.dart';

class InsertTradeBloc extends ChangeNotifier {
  WalletRepository _walletRepository;
  CryptosService _cryptosService;
  late InterstitialAd _interstitialAd;
  late BannerAd bannerAd;

  final formKey = GlobalKey<FormState>();
  TradeModel trade = TradeModel();

  late AppLocalizations appLocalizations;

  final statusNotifier = ValueNotifier<InsertTradeStatus>(InsertTradeStatus());
  InsertTradeStatus get status => statusNotifier.value;
  set status(InsertTradeStatus status) => statusNotifier.value = status;

  InsertTradeBloc(
      {required WalletRepository walletRepository,
      required CryptosService cryptosService})
      : _walletRepository = walletRepository,
        _cryptosService = cryptosService;

  String? validateDropdown(DropdownItem? value) {
    return value == null ? appLocalizations.errorFieldNull : null;
  }

  /// Validate [value], returns a message if there are any errors
  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) return appLocalizations.errorFieldNull;
    var number = double.tryParse(value);
    if (number == null) return appLocalizations.errorFieldNotNumber;
    return null;
  }

  String? validateCryptoAmount(String? value) {
    var error = _validateNumber(value);
    if (error == null) {
      return double.parse(value!) <= 0
          ? appLocalizations.errorFieldLessZeroOrZero
          : null;
    }
    return error;
  }

  String? validateTradedAmount(String? value) {
    var error = _validateNumber(value);
    if (error == null) {
      return double.parse(value!) < 0
          ? appLocalizations.errorFieldLessZero
          : null;
    }
    return error;
  }

  String? validateTradePrice(String? value) {
    var error = _validateNumber(value);
    if (error == null) {
      return double.parse(value!) < 0
          ? appLocalizations.errorFieldLessZero
          : null;
    }
    return error;
  }

  String? validateFee(String? value) {
    var number = double.tryParse(value!);
    if (number != null && number < 0)
      return appLocalizations.errorFieldLessZero;
    return null;
  }

  String? validateDate(String? value) {
    return value == null || value.length != 10
        ? appLocalizations.errorFieldWrongDate
        : null;
  }

  /// Check if app crypto list has been filled
  void checkCryptoList() {
    if (WalletHelper.coinsIsLoaded()) {
      status = InsertTradeStatus();
    } else {
      status = InsertTradeStatus.loading();
      Future.delayed(Duration(seconds: 1)).then((value) => checkCryptoList());
    }
  }

  /// Change the trade properties when the user changes a field
  void onChangeField({
    String? operationType,
    String? cryptoId,
    String? cryptoSymbol,
    double? amountDollars,
    double? fee,
    DateTime? date,
    String? user,
  }) {
    trade = trade.copyWith(
      operationType: operationType,
      amountDollars: amountDollars,
      cryptoId: cryptoId,
      cryptoSymbol: cryptoSymbol,
      date: date,
      fee: fee,
      user: user,
    );
  }

  /// Change the trade properties when the user changes crypto [amount] or [price]
  String onChangeCryptoAmountOrPrice({double? amount, double? price}) {
    var amountDollars = (amount ?? trade.amount) * (price ?? trade.price);
    // var result = amountDollars.toStringAsFixed(2);
    // amountDollars = double.parse(result);

    trade = trade.copyWith(
      amount: amount,
      amountDollars: amountDollars,
      price: price,
    );
    return amountDollars.toString();
  }

  Future<void> onSave({
    required WalletBloc walletBloc,
    required TradesBloc tradesBloc,
    required String uid,
  }) async {
    final form = formKey.currentState;

    if (!form!.validate()) throw Exception('Invalid form');

    status = InsertTradeStatus.loading();

    return await addTrade(trade).then((value) {
      tradesBloc.getTrades(uid);
      walletBloc.getCryptos(uid);
      trade = TradeModel(user: uid);
      status = InsertTradeStatus();
      if (_interstitialAd.responseInfo != null) _interstitialAd.show();
    }).catchError((error) {
      status = InsertTradeStatus.error(error.toString());
      throw Exception(error.toString());
    });
  }

  /// Add a [trade]
  Future<void> addTrade(TradeModel trade) async {
    var crypto =
        await _walletRepository.getCryptoById(trade.user!, trade.cryptoId);

    // Adding crypto for the first time
    if (crypto == null) {
      if (trade.operationType != TradeType.buy)
        throw Exception(appLocalizations.errorInsufficientBalance);

      var cryptoToCreate = _cryptosService.setCryptoForTheFirstTime(trade);

      await _walletRepository.addTrade(
          TradeCreateOption.create, trade, cryptoToCreate);
    }
    // Had crypto previously
    else {
      late CryptoModel updatedCrypto;

      //Check if the type of trade to set some properties
      trade = setTrade(trade, crypto.averagePrice);

      //If this trade is before the last one or if it is the first trade after sold all position
      if ((trade.date.compareTo(crypto.lastTradeAt) < 0) ||
          (crypto.soldPositionAt != null && crypto.amount == 0)) {
        var otherTrades = await _walletRepository.getTrades(trade.user!,
            cryptoId: trade.cryptoId);
        updatedCrypto = _cryptosService.recalculatingCryptoProperties(
            crypto, trade, otherTrades);
      } else {
        updatedCrypto =
            _cryptosService.calculateCryptoProperties(crypto, trade);
      }

      await _walletRepository.addTrade(
          TradeCreateOption.update, trade, updatedCrypto);
    }
  }

  /// Set [trade] profit, price and amount dollars according to the operation type and the crypto [averagePrice]
  ///
  /// When transfering, the trade price is the average price, and the Amount in Dollars is calculated using the fee
  TradeModel setTrade(TradeModel trade, double averagePrice) {
    if (trade.operationType == TradeType.transfer) {
      trade = trade.copyWith(
        price: averagePrice,
        amountDollars: trade.fee,
      );

      return trade;
    } else if (trade.operationType == TradeType.sell) {
      trade = trade.copyWith(
        profit: trade.amount * (trade.price - averagePrice),
      );

      return trade;
    }

    return trade;
  }

  void loadBannerAd() {
    bannerAd = AdHelper.bannerTradeRegisterAndDetails();
  }

  ///Load interstitialAd
  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialTradeOperation,
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
