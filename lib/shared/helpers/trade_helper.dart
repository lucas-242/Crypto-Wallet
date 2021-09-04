import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class TradeTypeHelper {
  /// Get the trade color indicator according to the type
  static TextStyle getTradeColor(TradeModel trade) =>
      trade.operationType == TradeType.buy
          ? AppTextStyles.captionBoldBody.copyWith(color: AppColors.green)
          : trade.operationType == TradeType.transfer
              ? AppTextStyles.captionBoldBody.copyWith(color: AppColors.input)
              : AppTextStyles.captionBoldBody.copyWith(color: AppColors.red);

  /// Get the Label trade type according to the language
  static String getTradeLabel(
          String operationType, AppLocalizations appLocalizations) =>
      operationType == TradeType.buy
          ? appLocalizations.buy
          : operationType == TradeType.transfer
              ? appLocalizations.transfer
              : appLocalizations.sell;
}
