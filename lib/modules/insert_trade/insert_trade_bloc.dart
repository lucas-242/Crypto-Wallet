import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:flutter/widgets.dart';

class InsertTradeBloc extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  Trade trade = Trade();

  String? validateAmount(String? value) =>
      value == null || double.parse(value) == 0
          ? "The amount can't be null"
          : null;
  String? validateDate(String? value) =>
      value?.isEmpty ?? true ? "The date can't be null" : null;
  String? validatePrice(String? value) =>
      value == null || double.parse(value) < 0
          ? "The trade must be equals or greater than \$0,00"
          : null;

  void onChange({
    String? operationType,
    String? crypto,
    double? amount,
    double? price,
    DateTime? date,
  }) {
    trade = trade.copyWith(
        operationType: operationType,
        amount: amount,
        crypto: crypto,
        date: date,
        price: price);
  }
}
