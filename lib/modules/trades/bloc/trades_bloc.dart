import 'package:crypto_wallet/modules/trades/bloc/trades_status.dart';
import 'package:crypto_wallet/repositories/trades_repository.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:flutter/cupertino.dart';

class TradesBloc extends ChangeNotifier {
  TradesRepository _tradesRepository;

  List<TradeModel> trades = [];
  List<DateTime> dates = [];

  final statusNotifier = ValueNotifier<TradesStatus>(TradesStatus());

  TradesStatus get status => statusNotifier.value;
  set status(TradesStatus status) => statusNotifier.value = status;

  TradesBloc({required TradesRepository tradesRepository})
      : _tradesRepository = tradesRepository;

  Future<void> getTrades(String uid) async {
    status = TradesStatus.loading();

    await _tradesRepository.getAllTrades(uid).then((value) {
      trades = value;
      trades.sort((a, b) => b.date!.compareTo(a.date!));
      dates = trades.map((e) => e.date!).toSet().toList();
      
      print('Dates: $dates');
    }).catchError((error) {
      status = TradesStatus.error(error);
      print(error);
    });

    status = TradesStatus();
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
