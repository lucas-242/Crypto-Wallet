import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    const mask = '##/##/####';
    final newText = StringBuffer();

    int i = 0;
    for (final maskChar in mask.characters) {
      if (i >= newValue.text.length) break;

      if (maskChar == '#') {
        newText.write(newValue.text[i]);
        i++;
      } else {
        newText.write(maskChar);
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
