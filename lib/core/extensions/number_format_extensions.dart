import 'package:crypto_wallet/core/utils/wallet_utils.dart';
import 'package:intl/intl.dart';

extension NumberFormatExtensions<T> on T {
  String formatCurrency([int? decimalDigits]) => NumberFormat.currency(
        symbol: '\$',
        decimalDigits:
            decimalDigits ?? WalletUtils.getDecimalDigits(this as double),
      ).format(this);

  int getDecimalDigits() => WalletUtils.getDecimalDigits(this as double);

  String formatPercent() => NumberFormat.decimalPercentPattern(decimalDigits: 1)
      .format((this as num) / 100);
}
