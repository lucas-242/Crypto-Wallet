import 'dart:convert';

class CryptoHistory {
  double? priceChangePercentage1yInCurrency;
  double? priceChangePercentage24hInCurrency;
  double? priceChangePercentage30dInCurrency;
  double? priceChangePercentage7dInCurrency;
  double? high24h;
  double? low24h;
  CryptoHistory({
    this.priceChangePercentage1yInCurrency,
    this.priceChangePercentage24hInCurrency,
    this.priceChangePercentage30dInCurrency,
    this.priceChangePercentage7dInCurrency,
    this.high24h,
    this.low24h,
  });

  CryptoHistory copyWith({
    double? priceChangePercentage1yInCurrency,
    double? priceChangePercentage24hInCurrency,
    double? priceChangePercentage30dInCurrency,
    double? priceChangePercentage7dInCurrency,
    double? high24h,
    double? low24h,
  }) {
    return CryptoHistory(
      priceChangePercentage1yInCurrency: priceChangePercentage1yInCurrency ??
          this.priceChangePercentage1yInCurrency,
      priceChangePercentage24hInCurrency: priceChangePercentage24hInCurrency ??
          this.priceChangePercentage24hInCurrency,
      priceChangePercentage30dInCurrency: priceChangePercentage30dInCurrency ??
          this.priceChangePercentage30dInCurrency,
      priceChangePercentage7dInCurrency: priceChangePercentage7dInCurrency ??
          this.priceChangePercentage7dInCurrency,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'priceChangePercentage1yInCurrency': priceChangePercentage1yInCurrency,
      'priceChangePercentage24hInCurrency': priceChangePercentage24hInCurrency,
      'priceChangePercentage30dInCurrency': priceChangePercentage30dInCurrency,
      'priceChangePercentage7dInCurrency': priceChangePercentage7dInCurrency,
      'high24h': high24h,
      'low24h': low24h,
    };
  }

  factory CryptoHistory.fromMap(Map<String, dynamic> map) {
    return CryptoHistory(
      priceChangePercentage1yInCurrency:
          map['priceChangePercentage1yInCurrency'],
      priceChangePercentage24hInCurrency:
          map['priceChangePercentage24hInCurrency'],
      priceChangePercentage30dInCurrency:
          map['priceChangePercentage30dInCurrency'],
      priceChangePercentage7dInCurrency:
          map['priceChangePercentage7dInCurrency'],
      high24h: map['high24h'],
      low24h: map['low24h'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoHistory.fromJson(String source) =>
      CryptoHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CryptoHistory(priceChangePercentage1yInCurrency: $priceChangePercentage1yInCurrency, priceChangePercentage24hInCurrency: $priceChangePercentage24hInCurrency, priceChangePercentage30dInCurrency: $priceChangePercentage30dInCurrency, priceChangePercentage7dInCurrency: $priceChangePercentage7dInCurrency, high24h: $high24h, low24h: $low24h)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CryptoHistory &&
        other.priceChangePercentage1yInCurrency ==
            priceChangePercentage1yInCurrency &&
        other.priceChangePercentage24hInCurrency ==
            priceChangePercentage24hInCurrency &&
        other.priceChangePercentage30dInCurrency ==
            priceChangePercentage30dInCurrency &&
        other.priceChangePercentage7dInCurrency ==
            priceChangePercentage7dInCurrency &&
        other.high24h == high24h &&
        other.low24h == low24h;
  }

  @override
  int get hashCode {
    return priceChangePercentage1yInCurrency.hashCode ^
        priceChangePercentage24hInCurrency.hashCode ^
        priceChangePercentage30dInCurrency.hashCode ^
        priceChangePercentage7dInCurrency.hashCode ^
        high24h.hashCode ^
        low24h.hashCode;
  }
}
