import 'keys.dart';
import '/shared/models/enums/environment.dart';

// * Properties that will be used inside config
const _admobTradeOperationAndroid = "admobTradeOperationAndroid";

/// System configs which are defined according to the initialization type that can be dev or prod
class Config {
  static late Map<String, dynamic> _config;

  /// This method must be called once in app initialization to set the environment type
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = {
          _admobTradeOperationAndroid: admob_unit_trade_operation_dev,
        };
        break;
      case Environment.prod:
        _config = {
          _admobTradeOperationAndroid: admob_unit_trade_operation_prod,
        };
        break;
    }
  }

  /// Admob Trade Operation key on Android
  static String get admobTradeOperationAndroid =>
      _config[_admobTradeOperationAndroid];

  /// Price that determines a small crypto
  static const smallCryptosPrice = 1.0;

  /// Number of decimal digits to cryptos
  static const decimalDigitsToCryptos = 2;

  /// Number of decimal digits to small cryptos
  static const decimalDigitsToSmallCryptos = 6;

  /// Coin api URL
  static const coingeckoApi = 'https://api.coingecko.com/api/v3/';

  /// Coin api limit number of items inside array
  static const apiResultLimit = 50;
}
