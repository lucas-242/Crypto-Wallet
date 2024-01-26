import 'package:equatable/equatable.dart';

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
