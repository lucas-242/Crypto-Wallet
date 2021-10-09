import 'dart:convert';

class CryptoInfoModel {
  String id;
  String name;
  String symbol;
  int color;
  
  CryptoInfoModel({
    required this.id,
    required this.name,
    required this.symbol,
    this.color = 0xFF424A57,
  });

  CryptoInfoModel copyWith({
    String? id,
    String? name,
    String? symbol,
    int? color,
  }) {
    return CryptoInfoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'color': color,
    };
  }

  factory CryptoInfoModel.fromMap(Map<String, dynamic> map) {
    return CryptoInfoModel(
      id: map['id'],
      name: map['name'],
      symbol: map['symbol'].toUpperCase(),
      color: map['color'] != null ? int.parse(map['color']) : 0xFF424A57,
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoInfoModel.fromJson(String source) => CryptoInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CryptoInfo(id: $id, name: $name, symbol: $symbol, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CryptoInfoModel &&
      other.id == id &&
      other.name == name &&
      other.symbol == symbol &&
      other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      symbol.hashCode ^
      color.hashCode;
  }
}
