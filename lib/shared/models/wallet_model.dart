import 'dart:ui';

import 'package:flutter/foundation.dart';

class WalletModel {
  double totalNow;
  double totalInvested;
  double variation;
  double percentVariation;

  List<CryptoSummary> cryptosSummary;

  WalletModel({
    this.totalNow = 0,
    this.totalInvested = 0,
    this.variation = 0,
    this.percentVariation = 0,
    this.cryptosSummary = const [],
  });

  WalletModel copyWith({
    double? totalNow,
    double? totalInvested,
    double? variation,
    double? percentVariation,
    List<CryptoSummary>? cryptosSummary,
  }) {
    return WalletModel(
      totalInvested: totalInvested ?? this.totalInvested,
      totalNow: totalNow ?? this.totalNow,
      variation: variation ?? this.variation,
      percentVariation: percentVariation ?? this.percentVariation,
      cryptosSummary: cryptosSummary ?? this.cryptosSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletModel &&
        other.totalInvested == totalInvested &&
        other.totalNow == totalNow &&
        other.variation == variation &&
        other.percentVariation == percentVariation &&
        listEquals(other.cryptosSummary, cryptosSummary);
  }

  @override
  int get hashCode {
    return totalNow.hashCode ^
        totalInvested.hashCode ^
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
