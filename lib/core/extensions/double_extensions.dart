/// Precision to calculate decimal numbers
const int _precision = 100000000;

extension DoubleExtensions on double {
  /// Sum two numbers avoiding problems with precision
  double sum(double value) {
    final sum = (this * _precision).roundToDouble() +
        (value * _precision).roundToDouble();

    final result = sum / _precision;
    return result;
  }

  /// Subtract two numbers avoiding problems with precision
  double sub(double value) {
    final difference = (this * _precision).roundToDouble() -
        (value * _precision).roundToDouble();

    final result = difference / _precision;
    return result;
  }
}
