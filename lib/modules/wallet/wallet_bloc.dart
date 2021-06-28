import 'package:crypto_wallet/modules/wallet/wallet_status.dart';
import 'package:crypto_wallet/repositories/trades_repository.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:flutter/cupertino.dart';

class WalletBloc extends ChangeNotifier {
  TradesRepository _tradesRepository;

  List<TradeModel> trades = [];
  List<DateTime> dates = [];

  final statusNotifier = ValueNotifier<WalletStatus>(WalletStatus());

  WalletStatus get status => statusNotifier.value;
  set status(WalletStatus status) => statusNotifier.value = status;

  WalletBloc({required TradesRepository tradesRepository})
      : _tradesRepository = tradesRepository;

  Future<void> getTrades(String uid) async {
    status = WalletStatus.loading();

    await Future.delayed(Duration(seconds: 7));

    await _tradesRepository.getAllTrades(uid).then((value) {
      trades = value;
      trades.sort((a, b) => b.date!.compareTo(a.date!));
      dates = trades.map((e) => e.date!).toList();
      print('Trades: $trades');
      print('Dates: $dates');
    }).catchError((error) {
      status = WalletStatus.error(error);
      print(error);
    });

    status = WalletStatus();
  }

  List<TradeModel> getTradesByDate(DateTime date) =>
      trades.where((element) => element.date == date).toList();
}
