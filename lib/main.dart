import 'package:crypto_wallet/main_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  // initializeDateFormatting();
  MobileAds.instance.initialize();
  runApp(MainFirebase());
}
