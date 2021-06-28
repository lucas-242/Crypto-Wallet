import 'package:crypto_wallet/main_firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  runApp(MainFirebase());
}
