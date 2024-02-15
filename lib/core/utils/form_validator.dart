import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/dropdown_item.dart';

abstract class FormValidator {
  static String? validateDropdown(DropdownItem? value) =>
      value == null ? AppLocalizations.current.errorFieldNull : null;

  static String? validateCryptoAmount(String? value) {
    final error = _validateIsNumber(value);
    if (error == null) {
      return double.parse(value!) <= 0
          ? AppLocalizations.current.errorFieldLessZeroOrZero
          : null;
    }
    return error;
  }

  static String? _validateIsNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.errorFieldNull;
    }

    final number = double.tryParse(value);
    if (number == null) return AppLocalizations.current.errorFieldNotNumber;
    return null;
  }

  static String? validateTradedAmount(String? value) {
    final error = _validateIsNumber(value);
    if (error != null) {
      return error;
    }
    return _validateIsZero(value!);
  }

  static String? _validateIsZero(String value) => double.parse(value) < 0
      ? AppLocalizations.current.errorFieldLessZero
      : null;

  static String? validateTradePrice(String? value) {
    final error = _validateIsNumber(value);
    if (error != null) {
      return error;
    }
    return _validateIsZero(value!);
  }

  static String? validateFee(String? value) {
    final number = double.tryParse(value!);
    if (number != null && number < 0) {
      return AppLocalizations.current.errorFieldLessZero;
    }
    return null;
  }

  static String? validateDate(String? value) {
    return value == null || value.length != 10
        ? AppLocalizations.current.errorFieldWrongDate
        : null;
  }
}
