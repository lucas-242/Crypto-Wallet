import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet extends Equatable {
  const Wallet({
    this.totalNow = 0,
    this.totalInvested = 0,
    this.variation = 0,
    this.percentVariation = 0,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);

  final double totalNow;
  final double totalInvested;
  final double variation;
  final double percentVariation;

  Wallet copyWith({
    double? totalNow,
    double? totalInvested,
    double? variation,
    double? percentVariation,
  }) {
    return Wallet(
      totalInvested: totalInvested ?? this.totalInvested,
      totalNow: totalNow ?? this.totalNow,
      variation: variation ?? this.variation,
      percentVariation: percentVariation ?? this.percentVariation,
    );
  }

  @override
  List<Object?> get props => [
        totalNow,
        totalInvested,
        variation,
        percentVariation,
      ];
}
