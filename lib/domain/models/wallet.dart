import 'package:equatable/equatable.dart';

import 'crypto_summary.dart';

class Wallet extends Equatable {
  const Wallet({
    this.totalNow = 0,
    this.totalInvested = 0,
    this.variation = 0,
    this.percentVariation = 0,
    this.cryptosSummary = const [],
  });
  final double totalNow;
  final double totalInvested;
  final double variation;
  final double percentVariation;
  final List<CryptoSummary> cryptosSummary;

  Wallet copyWith({
    double? totalNow,
    double? totalInvested,
    double? variation,
    double? percentVariation,
    List<CryptoSummary>? cryptosSummary,
  }) {
    return Wallet(
      totalInvested: totalInvested ?? this.totalInvested,
      totalNow: totalNow ?? this.totalNow,
      variation: variation ?? this.variation,
      percentVariation: percentVariation ?? this.percentVariation,
      cryptosSummary: cryptosSummary ?? this.cryptosSummary,
    );
  }

  @override
  List<Object?> get props => [
        totalNow,
        totalInvested,
        variation,
        percentVariation,
        cryptosSummary,
      ];
}
