import 'dart:ui';

import 'package:equatable/equatable.dart';

//Represents the Crypto Entity for the App
final class Crypto extends Equatable {
  const Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.color,
    this.image,
    this.currentPrice = 0,
    this.priceChange1y,
    this.priceChange24h,
    this.priceChange30d,
    this.priceChange7d,
    this.high24h,
    this.low24h,
  });

  final String id;
  final String name;
  final String symbol;

  final Color color;
  final String? image;
  final double currentPrice;
  final double? priceChange24h;
  final double? priceChange7d;
  final double? priceChange30d;
  final double? priceChange1y;
  final double? high24h;
  final double? low24h;

  double? get priceChangePercentage24h =>
      priceChange24h != null ? priceChange24h! / currentPrice * 100 : null;

  double? get priceChangePercentage7d =>
      priceChange7d != null ? priceChange7d! / currentPrice * 100 : null;

  double? get priceChangePercentage30d =>
      priceChange30d != null ? priceChange30d! / currentPrice * 100 : null;

  double? get priceChangePercentage1y =>
      priceChange1y != null ? priceChange1y! / currentPrice * 100 : null;

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        color,
        image,
        currentPrice,
        priceChange1y,
        priceChange24h,
        priceChange30d,
        priceChange7d,
        high24h,
        low24h,
      ];
}
