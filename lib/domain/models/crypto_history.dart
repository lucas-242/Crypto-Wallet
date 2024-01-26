import 'package:equatable/equatable.dart';

class CryptoHistory extends Equatable {
  const CryptoHistory({
    this.priceChangePercentage1yInCurrency,
    this.priceChangePercentage24hInCurrency,
    this.priceChangePercentage30dInCurrency,
    this.priceChangePercentage7dInCurrency,
    this.high24h,
    this.low24h,
  });

  final double? priceChangePercentage1yInCurrency;
  final double? priceChangePercentage24hInCurrency;
  final double? priceChangePercentage30dInCurrency;
  final double? priceChangePercentage7dInCurrency;
  final double? high24h;
  final double? low24h;

  @override
  List<Object?> get props => [
        priceChangePercentage1yInCurrency,
        priceChangePercentage24hInCurrency,
        priceChangePercentage30dInCurrency,
        priceChangePercentage7dInCurrency,
        high24h,
        low24h,
      ];
}
