import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_summary.g.dart';

@JsonSerializable()
class CryptoSummary extends Equatable {
  const CryptoSummary({
    required this.cryptoId,
    required this.crypto,
    required this.name,
    this.image,
    this.color = 0,
    this.value = 0,
    this.amount = 0,
    this.percent = 0,
  });

  factory CryptoSummary.fromJson(Map<String, dynamic> json) =>
      _$CryptoSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoSummaryToJson(this);

  final String cryptoId;
  final String crypto;
  final String name;
  final int color;
  final String? image;
  final double value;
  final double amount;
  final double percent;

  @override
  List<Object?> get props => [
        cryptoId,
        crypto,
        name,
        color,
        image,
        value,
        amount,
        percent,
      ];
}
