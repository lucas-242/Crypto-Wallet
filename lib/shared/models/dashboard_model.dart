import 'dart:ui';

import 'package:flutter/foundation.dart';

class DashboardModel {
  double total;
  double variation;
  double percentVariation;

  List<CryptoSummary> cryptosSummary;

  DashboardModel({
    this.total = 0,
    this.variation = 0,
    this.percentVariation = 0,
    this.cryptosSummary = const [],
  });

  DashboardModel copyWith({
    double? total,
    double? variation,
    double? percentVariation,
    List<CryptoSummary>? cryptosSummary,
  }) {
    return DashboardModel(
      total: total ?? this.total,
      variation: variation ?? this.variation,
      percentVariation: percentVariation ?? this.percentVariation,
      cryptosSummary: cryptosSummary ?? this.cryptosSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardModel &&
        other.total == total &&
        other.variation == variation &&
        other.percentVariation == percentVariation &&
        listEquals(other.cryptosSummary, cryptosSummary);
  }

  @override
  int get hashCode {
    return total.hashCode ^
        variation.hashCode ^
        percentVariation.hashCode ^
        cryptosSummary.hashCode;
  }
}

class CryptoSummary {
  String crypto;
  String name;
  Color? color;
  String? image;
  double value;
  double amount;
  double percent;

  CryptoSummary({
    required this.crypto,
    required this.name,
    this.image,
    this.color,
    this.value = 0,
    this.amount = 0,
    this.percent = 0,
  });
}
