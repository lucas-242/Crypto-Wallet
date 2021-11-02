import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/cryptos.dart';
import '../core/trade_type.dart';
import './../models/trade_model.dart';
import './../themes/themes.dart';
import './wallet_helper.dart';

abstract class ViewHelper {
  /// Get the trade color indicator according to the type
  static TextStyle getTradeColor(TradeModel trade) =>
      trade.operationType == TradeType.buy
          ? AppTextStyles.bodyBold.copyWith(color: AppColors.green)
          : trade.operationType == TradeType.transfer
              ? AppTextStyles.bodyBold.copyWith(color: AppColors.input)
              : AppTextStyles.bodyBold.copyWith(color: AppColors.red);

  /// Get the Label trade type according to the language
  static String getTradeLabel(
          String operationType, AppLocalizations appLocalizations) =>
      operationType == TradeType.buy
          ? appLocalizations.buy
          : operationType == TradeType.transfer
              ? appLocalizations.transfer
              : appLocalizations.sell;

  ///Get coin color by [id]
  static Color getCoinColor(String id) {
    var found = WalletHelper.findCoin(id);
    return Cryptos.colors[found.id] != null
        ? Color(Cryptos.colors[found.id]!)
        : AppColors.text;
  }
}
