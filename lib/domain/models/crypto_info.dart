import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_info.g.dart';

@JsonSerializable(createToJson: false)
class CryptoInfo extends Equatable {
  const CryptoInfo({
    required this.id,
    required this.name,
    required this.symbol,
    this.color = 0xFF424A57,
  });

  factory CryptoInfo.fromJson(Map<String, dynamic> json) =>
      _$CryptoInfoFromJson(json);

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
