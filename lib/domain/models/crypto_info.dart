import 'package:equatable/equatable.dart';

class CryptoInfo extends Equatable {
  const CryptoInfo({
    required this.id,
    required this.name,
    required this.symbol,
    this.color = 0xFF424A57,
  });

  final String id;
  final String name;
  final String symbol;
  final int color;

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        color,
      ];
}
