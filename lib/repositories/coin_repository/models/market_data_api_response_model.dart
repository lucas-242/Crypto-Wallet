import 'dart:convert';

class MarketDataApiResponse {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  double marketCap;
  double marketCapRank;
  double fullyDilutedValuation;
  double totalVolume;
  double high24h;
  double low24h;
  double priceChange24h;
  double priceChangePercentage24h;
  double marketCapChange24h;
  double marketCapChangePercentage24h;
  double circulatingSupply;
  double totalSupply;
  double maxSupply;
  double ath;
  double athChangePercentage;
  String athDate;
  double atl;
  double atlChangePercentage;
  String atlDate;
  String lastUpdated;
  double priceChangePercentage1yInCurrency;
  double priceChangePercentage24hInCurrency;
  double priceChangePercentage30dInCurrency;
  double priceChangePercentage7dInCurrency;

  MarketDataApiResponse({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapChange24h,
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.lastUpdated,
    required this.priceChangePercentage1yInCurrency,
    required this.priceChangePercentage24hInCurrency,
    required this.priceChangePercentage30dInCurrency,
    required this.priceChangePercentage7dInCurrency,
  });

  MarketDataApiResponse copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? currentPrice,
    double? marketCap,
    double? marketCapRank,
    double? fullyDilutedValuation,
    double? totalVolume,
    double? high24h,
    double? low24h,
    double? priceChange24h,
    double? priceChangePercentage24h,
    double? marketCapChange24h,
    double? marketCapChangePercentage24h,
    double? circulatingSupply,
    double? totalSupply,
    double? maxSupply,
    double? ath,
    double? athChangePercentage,
    String? athDate,
    double? atl,
    double? atlChangePercentage,
    String? atlDate,
    String? lastUpdated,
    double? priceChangePercentage1yInCurrency,
    double? priceChangePercentage24hInCurrency,
    double? priceChangePercentage30dInCurrency,
    double? priceChangePercentage7dInCurrency,
  }) {
    return MarketDataApiResponse(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      fullyDilutedValuation:
          fullyDilutedValuation ?? this.fullyDilutedValuation,
      totalVolume: totalVolume ?? this.totalVolume,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      priceChange24h: priceChange24h ?? this.priceChange24h,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
      marketCapChange24h: marketCapChange24h ?? this.marketCapChange24h,
      marketCapChangePercentage24h:
          marketCapChangePercentage24h ?? this.marketCapChangePercentage24h,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      maxSupply: maxSupply ?? this.maxSupply,
      ath: ath ?? this.ath,
      athChangePercentage: athChangePercentage ?? this.athChangePercentage,
      athDate: athDate ?? this.athDate,
      atl: atl ?? this.atl,
      atlChangePercentage: atlChangePercentage ?? this.atlChangePercentage,
      atlDate: atlDate ?? this.atlDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      priceChangePercentage1yInCurrency: priceChangePercentage1yInCurrency ??
          this.priceChangePercentage1yInCurrency,
      priceChangePercentage24hInCurrency: priceChangePercentage24hInCurrency ??
          this.priceChangePercentage24hInCurrency,
      priceChangePercentage30dInCurrency: priceChangePercentage30dInCurrency ??
          this.priceChangePercentage30dInCurrency,
      priceChangePercentage7dInCurrency: priceChangePercentage7dInCurrency ??
          this.priceChangePercentage7dInCurrency,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'currentPrice': currentPrice,
      'marketCap': marketCap,
      'marketCapRank': marketCapRank,
      'fullyDilutedValuation': fullyDilutedValuation,
      'totalVolume': totalVolume,
      'high24h': high24h,
      'low24h': low24h,
      'priceChange24h': priceChange24h,
      'priceChangePercentage24h': priceChangePercentage24h,
      'marketCapChange24h': marketCapChange24h,
      'marketCapChangePercentage24h': marketCapChangePercentage24h,
      'circulatingSupply': circulatingSupply,
      'totalSupply': totalSupply,
      'maxSupply': maxSupply,
      'ath': ath,
      'athChangePercentage': athChangePercentage,
      'athDate': athDate,
      'atl': atl,
      'atlChangePercentage': atlChangePercentage,
      'atlDate': atlDate,
      'lastUpdated': lastUpdated,
      'priceChangePercentage1yInCurrency': priceChangePercentage1yInCurrency,
      'priceChangePercentage24hInCurrency': priceChangePercentage24hInCurrency,
      'priceChangePercentage30dInCurrency': priceChangePercentage30dInCurrency,
      'priceChangePercentage7dInCurrency': priceChangePercentage7dInCurrency,
    };
  }

  factory MarketDataApiResponse.fromMap(Map<String, dynamic> map) {
    return MarketDataApiResponse(
      id: map['id'],
      symbol: map['symbol'],
      name: map['name'],
      image: map['image'],
      currentPrice: map['current_price'].toDouble(),
      marketCap: map['market_cap'].toDouble(),
      marketCapRank: map['market_cap_rank'].toDouble(),
      fullyDilutedValuation: map['fully_diluted_valuation'].toDouble(),
      totalVolume: map['total_volume'].toDouble(),
      high24h: map['high_24h'].toDouble(),
      low24h: map['low_24h'].toDouble(),
      priceChange24h: map['price_change_24h'].toDouble(),
      priceChangePercentage24h: map['price_change_percentage_24h'].toDouble(),
      marketCapChange24h: map['market_cap_change_24h'].toDouble(),
      marketCapChangePercentage24h:
          map['market_cap_change_percentage_24h'].toDouble(),
      circulatingSupply: map['circulating_supply'].toDouble(),
      totalSupply: map['total_supply'].toDouble(),
      maxSupply: map['max_supply'].toDouble(),
      ath: map['ath'].toDouble(),
      athChangePercentage: map['ath_change_percentage'].toDouble(),
      athDate: map['ath_date'],
      atl: map['atl'].toDouble(),
      atlChangePercentage: map['atl_change_percentage'].toDouble(),
      atlDate: map['atl_date'],
      lastUpdated: map['last_updated'],
      priceChangePercentage1yInCurrency:
          map['price_change_percentage_1y_in_currency'].toDouble(),
      priceChangePercentage24hInCurrency:
          map['price_change_percentage_24h_in_currency'].toDouble(),
      priceChangePercentage30dInCurrency:
          map['price_change_percentage_30d_in_currency'].toDouble(),
      priceChangePercentage7dInCurrency:
          map['price_change_percentage_7d_in_currency'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketDataApiResponse.fromJson(String source) =>
      MarketDataApiResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CryptoMarketData(id: $id, symbol: $symbol, name: $name, image: $image, currentPrice: $currentPrice, marketCap: $marketCap, marketCapRank: $marketCapRank, fullyDilutedValuation: $fullyDilutedValuation, totalVolume: $totalVolume, high24h: $high24h, low24h: $low24h, priceChange24h: $priceChange24h, priceChangePercentage24h: $priceChangePercentage24h, marketCapChange24h: $marketCapChange24h, marketCapChangePercentage24h: $marketCapChangePercentage24h, circulatingSupply: $circulatingSupply, totalSupply: $totalSupply, maxSupply: $maxSupply, ath: $ath, athChangePercentage: $athChangePercentage, athDate: $athDate, atl: $atl, atlChangePercentage: $atlChangePercentage, atlDate: $atlDate, lastUpdated: $lastUpdated, priceChangePercentage1yInCurrency: $priceChangePercentage1yInCurrency, priceChangePercentage24hInCurrency: $priceChangePercentage24hInCurrency, priceChangePercentage30dInCurrency: $priceChangePercentage30dInCurrency, priceChangePercentage7dInCurrency: $priceChangePercentage7dInCurrency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarketDataApiResponse &&
        other.id == id &&
        other.symbol == symbol &&
        other.name == name &&
        other.image == image &&
        other.currentPrice == currentPrice &&
        other.marketCap == marketCap &&
        other.marketCapRank == marketCapRank &&
        other.fullyDilutedValuation == fullyDilutedValuation &&
        other.totalVolume == totalVolume &&
        other.high24h == high24h &&
        other.low24h == low24h &&
        other.priceChange24h == priceChange24h &&
        other.priceChangePercentage24h == priceChangePercentage24h &&
        other.marketCapChange24h == marketCapChange24h &&
        other.marketCapChangePercentage24h == marketCapChangePercentage24h &&
        other.circulatingSupply == circulatingSupply &&
        other.totalSupply == totalSupply &&
        other.maxSupply == maxSupply &&
        other.ath == ath &&
        other.athChangePercentage == athChangePercentage &&
        other.athDate == athDate &&
        other.atl == atl &&
        other.atlChangePercentage == atlChangePercentage &&
        other.atlDate == atlDate &&
        other.lastUpdated == lastUpdated &&
        other.priceChangePercentage1yInCurrency ==
            priceChangePercentage1yInCurrency &&
        other.priceChangePercentage24hInCurrency ==
            priceChangePercentage24hInCurrency &&
        other.priceChangePercentage30dInCurrency ==
            priceChangePercentage30dInCurrency &&
        other.priceChangePercentage7dInCurrency ==
            priceChangePercentage7dInCurrency;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        symbol.hashCode ^
        name.hashCode ^
        image.hashCode ^
        currentPrice.hashCode ^
        marketCap.hashCode ^
        marketCapRank.hashCode ^
        fullyDilutedValuation.hashCode ^
        totalVolume.hashCode ^
        high24h.hashCode ^
        low24h.hashCode ^
        priceChange24h.hashCode ^
        priceChangePercentage24h.hashCode ^
        marketCapChange24h.hashCode ^
        marketCapChangePercentage24h.hashCode ^
        circulatingSupply.hashCode ^
        totalSupply.hashCode ^
        maxSupply.hashCode ^
        ath.hashCode ^
        athChangePercentage.hashCode ^
        athDate.hashCode ^
        atl.hashCode ^
        atlChangePercentage.hashCode ^
        atlDate.hashCode ^
        lastUpdated.hashCode ^
        priceChangePercentage1yInCurrency.hashCode ^
        priceChangePercentage24hInCurrency.hashCode ^
        priceChangePercentage30dInCurrency.hashCode ^
        priceChangePercentage7dInCurrency.hashCode;
  }
}
