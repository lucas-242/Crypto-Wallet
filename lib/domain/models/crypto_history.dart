import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_history.g.dart';

@JsonSerializable()
class CryptoHistory extends Equatable {
  const CryptoHistory({
    this.priceChangePercentage1yInCurrency,
    this.priceChangePercentage24hInCurrency,
    this.priceChangePercentage30dInCurrency,
    this.priceChangePercentage7dInCurrency,
    this.high24h,
    this.low24h,
  });

  factory CryptoHistory.fromJson(Map<String, dynamic> json) =>
      _$CryptoHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoHistoryToJson(this);

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
