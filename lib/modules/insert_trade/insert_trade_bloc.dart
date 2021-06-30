import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/repositories/trades_repository.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/models/trade_type.dart';
import 'package:flutter/widgets.dart';

import 'insert_trade_status.dart';

class InsertTradeBloc extends ChangeNotifier {
  TradesRepository _tradesRepository;

  final formKey = GlobalKey<FormState>();
  TradeModel trade = TradeModel();

  final initialValueOperationType = TradeType.BUY;
  final initialValueCrypto = Cryptos.BTC;

  final statusNotifier = ValueNotifier<InsertTradeStatus>(InsertTradeStatus());

  InsertTradeStatus get status => statusNotifier.value;
  set status(InsertTradeStatus status) => statusNotifier.value = status;

  InsertTradeBloc({required TradesRepository tradesRepository})
      : _tradesRepository = tradesRepository;

  String? validateAmount(String? value) {
    return value == null ||
            double.parse(value.replaceAll(RegExp(','), '.')) == 0
        ? "The amount can't be null"
        : null;
  }

  String? validateDate(String? value) {
    return value == null || value.length != 10 ? "Insert a valid date" : null;
  }

  String? validatePrice(String? value) {
    if (value != null) {
      //Remove $, . from the middle of the number and change , to .
      value = value
          .substring(1)
          .replaceAll(RegExp(r'\.'), '')
          .replaceAll(RegExp(','), '.');

      print(value);

      return double.parse(value) < 0
          ? "The trade must be equals or greater than \$0,00"
          : null;
    }

    return null;
  }

  void onChange({
    String? operationType,
    String? crypto,
    double? amount,
    double? price,
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
      crypto: crypto,
      date: formattedDate,
      price: price,
      user: user,
    );
  }

  Future<void> addTrade(WalletBloc walletBloc) async {
    final form = formKey.currentState;

    if (!form!.validate()) return;

    status = InsertTradeStatus.loading();

    return await _tradesRepository.addTrade(trade).then((value) {
      if (value == null) {
        status = InsertTradeStatus.error('Error to add trade');
        return null;
      }

      walletBloc.addTrade(value);
      trade = TradeModel();
      status = InsertTradeStatus();
    }).catchError((error) {
      print(error);
      status = InsertTradeStatus.error(error);
    });
  }
}
