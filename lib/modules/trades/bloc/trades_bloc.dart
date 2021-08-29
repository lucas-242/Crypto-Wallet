import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/helpers/ad_helper.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:flutter/foundation.dart';
import 'package:crypto_wallet/shared/extensions/date_time_extension.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TradesBloc extends ChangeNotifier {
  WalletRepository _walletRepository;
  late InterstitialAd _interstitialAd;

  List<TradeModel> trades = [];
  List<DateTime> dates = [];

  final statusNotifier = ValueNotifier<TradesStatus>(TradesStatus());

  TradesStatus get status => statusNotifier.value;
  set status(TradesStatus status) => statusNotifier.value = status;

  TradesBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository;

  Future<void> getTrades(String uid) async {
    status = TradesStatus.loading();

    await _walletRepository.getTrades(uid: uid).then((value) {
      trades = value;
      trades.sort((a, b) => b.date.compareTo(a.date));
      dates = trades.map((e) => e.date).toSet().toList();
    }).catchError((error) {
      status = TradesStatus.error(error.toString());
      print(error);
    });

    if (trades.isEmpty) {
      status = TradesStatus.noData();
    } else {
      status = TradesStatus();
    }
    notifyListeners();
  }

  List<TradeModel> getTradesByDate(DateTime date) =>
      trades.where((element) => element.date == date).toList();

  void addTrade(TradeModel trade) {
    trades.add(trade);
    trades.sort((a, b) => b.date.compareTo(a.date));

    if (dates.where((element) => element == trade.date).isEmpty) {
      dates.add(trade.date);
      dates.sort((a, b) => b.compareTo(a));
    }

    notifyListeners();
  }

  Future<void> deleteTrade({
    required TradeModel trade,
    required String uid,
    required WalletBloc walletBloc,
  }) async {
    status = TradesStatus.loading();

    var cryptos = await _walletRepository.getCryptos(uid);
    var found =
        cryptos.where((element) => element.cryptoId.compareTo(trade.cryptoId) == 0);

    if (found.isEmpty) {
      status =
          TradesStatus.error('Something is wrong. Please, restart the app');
      return;
    }

    if (_interstitialAd.responseInfo != null) _interstitialAd.show();

    var crypto = found.first;
    var tradesFiltered = trades
        .where((element) => element.cryptoId == trade.cryptoId && element != trade)
        .toList();
    await _walletRepository
        .deleteTrade(crypto, tradesFiltered, trade)
        .then((value) {
      trades.removeWhere((element) => element.id == trade.id);

      var findTrades =
          trades.where((element) => element.date.isSameDate(trade.date));
      if (findTrades.isEmpty) {
        dates.removeWhere((element) => element.isSameDate(trade.date));
      }

      walletBloc.getCryptos(uid);
      status = TradesStatus();
    }).catchError((error) {
      status = TradesStatus.error(error.toString());
    });

    notifyListeners();
  }

  ///Load the InterstitialAd
  loadAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void disposeInterstitialAd() {
    _interstitialAd.dispose();
  }

  void eraseData() {
    trades = [];
    dates = [];
    notifyListeners();
  }
}
