import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

abstract class WalletUtils {
  /// Price that determines a small crypto
  static const smallCryptosPrice = 1.0;

  /// Number of decimal digits to cryptos
  static const decimalDigitsToCryptos = 2;

  /// Number of decimal digits to small cryptos
  static const decimalDigitsToSmallCryptos = 6;

  ///Get decimal digits according to the crypto [price]
  static int getDecimalDigits(double price) => price < smallCryptosPrice
      ? decimalDigitsToSmallCryptos
      : decimalDigitsToCryptos;

  /// Get the trade color indicator according to the type
  static TextStyle getTradeColor(Trade trade) {
    if (trade.operationType == TradeType.buy) {
      return AppTextStyles.subtitleMd.copyWith(color: AppColors.green);
    } else if (trade.operationType == TradeType.transfer) {
      return AppTextStyles.subtitleMd.copyWith(color: AppColors.grey);
    }

    return AppTextStyles.subtitleMd.copyWith(color: AppColors.red);
  }

  /// Get the Label trade type according to the language
  static String getTradeLabel(String operationType) {
    if (operationType == TradeType.buy) {
      return AppLocalizations.current.buy;
    } else if (operationType == TradeType.transfer) {
      return AppLocalizations.current.transfer;
    }

    return AppLocalizations.current.sell;
  }
}
