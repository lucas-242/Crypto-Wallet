import 'package:intl/intl.dart';

extension NumberFormatExtensions<T> on T {
  String formatCurrency() => NumberFormat.currency(symbol: '\$').format(this);

  String formatPercent() => NumberFormat.decimalPercentPattern(decimalDigits: 1)
      .format((this as num) / 100);
}
