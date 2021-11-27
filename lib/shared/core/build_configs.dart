import 'keys.dart';
import '/shared/models/enums/environment.dart';

// * Properties that will be used inside config
const _admobInterstitialTradeOperationAndroid =
    "admobIntersticialTradeOperationAndroid";
const _admobBannerTradeRegisterAndroid = "admobBannerTradeRegisterAndroid";
const _admobBannerTradesListAndroid = "admobBannerTradesListAndroid";

/// System configs which are defined according to the initialization type that can be dev or prod
class Config {
  static late Map<String, dynamic> _config;

  /// This method must be called once in app initialization to set the environment type
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = {
          _admobInterstitialTradeOperationAndroid:
              admob_interstitial_trade_operation_dev,
          _admobBannerTradeRegisterAndroid: admob_banner_trade_register_details_dev,
          _admobBannerTradesListAndroid: admob_banner_trades_list_dev,
        };
        break;
      case Environment.prod:
        _config = {
          _admobInterstitialTradeOperationAndroid:
              admob_interstitial_trade_operation_prod,
          _admobBannerTradeRegisterAndroid: admob_banner_trade_register_details_prod,
          _admobBannerTradesListAndroid: admob_banner_trades_list_prod,
        };
        break;
    }
  }

  /// Admob Trade Operation key on Android
  static String get admobInterstitialTradeOperationAndroid =>
      _config[_admobInterstitialTradeOperationAndroid];

  /// Admob Trade Register key on Android
  static String get admobBannerTradeRegisterAndDetailsAndroid =>
      _config[_admobBannerTradeRegisterAndroid];

  /// Admob Trade List key on Android
  static String get admobBannerTradesListAndroid =>
      _config[_admobBannerTradesListAndroid];

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
