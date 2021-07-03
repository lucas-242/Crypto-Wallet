import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/repositories/wallet_repository.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:flutter/foundation.dart';

class TradesBloc extends ChangeNotifier {
  WalletRepository _walletRepository;

  List<TradeModel> trades = [];
  List<DateTime> dates = [];

  final statusNotifier = ValueNotifier<TradesStatus>(TradesStatus());

  TradesStatus get status => statusNotifier.value;
  set status(TradesStatus status) => statusNotifier.value = status;

  TradesBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository;

  Future<void> getTrades(String uid) async {
    status = TradesStatus.loading();

    await _walletRepository.getAllTrades(uid).then((value) {
      trades = value;
      trades.sort((a, b) => b.date!.compareTo(a.date!));
      dates = trades.map((e) => e.date!).toSet().toList();

      print('Dates: $dates');
    }).catchError((error) {
      status = TradesStatus.error(error);
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
    trades.sort((a, b) => b.date!.compareTo(a.date!));

    if (dates.where((element) => element == trade.date!).isEmpty) {
      dates.add(trade.date!);
      dates.sort((a, b) => b.compareTo(a));
    }

    notifyListeners();
  }
}
