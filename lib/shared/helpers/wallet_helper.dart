abstract class WalletHelper {
  static int decimalDigitsToCryptos = 2;
  static int decimalDigitsToSmallCryptos = 6;
  static int smallCryptosPrice = 1;

  ///Get decimal digits according to the crypto [price]
  static int getDecimalDigits(double price) {
    return price < smallCryptosPrice ? decimalDigitsToSmallCryptos : decimalDigitsToCryptos;
  }
}
