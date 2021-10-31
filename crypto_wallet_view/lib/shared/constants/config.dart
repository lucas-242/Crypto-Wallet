/// System Configs
abstract class Config {
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
