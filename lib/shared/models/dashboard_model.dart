import 'dart:convert';

class Dashboard {
  double total;
  double variation;
  double percentVariation;

  Dashboard({
    this.total = 0,
    this.variation = 0,
    this.percentVariation = 0,
  });

  Dashboard copyWith({
    double? total,
    double? variation,
    double? percentVariation,
  }) {
    return Dashboard(
      total: total ?? this.total,
      variation: variation ?? this.variation,
      percentVariation: percentVariation ?? this.percentVariation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'variation': variation,
      'percentVariation': percentVariation,
    };
  }

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    return Dashboard(
      total: map['total'],
      variation: map['variation'],
      percentVariation: map['percentVariation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dashboard.fromJson(String source) =>
      Dashboard.fromMap(json.decode(source));

  @override
  String toString() =>
      'Dashboard(total: $total, variation: $variation, percentVariation: $percentVariation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dashboard &&
        other.total == total &&
        other.variation == variation &&
        other.percentVariation == percentVariation;
  }

  @override
  int get hashCode =>
      total.hashCode ^ variation.hashCode ^ percentVariation.hashCode;
}
