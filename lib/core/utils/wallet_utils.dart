abstract class WalletUtils {
  /// Price that determines a small crypto
  static const smallCryptosPrice = 1.0;

  /// Number of decimal digits to cryptos
  static const decimalDigitsToCryptos = 2;

  /// Number of decimal digits to small cryptos
  static const decimalDigitsToSmallCryptos = 6;

  ///Get decimal digits according to the crypto [price]
  static int getDecimalDigits(double price) {
    return price < smallCryptosPrice
        ? decimalDigitsToSmallCryptos
        : decimalDigitsToCryptos;
  }
}
