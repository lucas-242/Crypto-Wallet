import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firebase_crypto_model.g.dart';

@JsonSerializable()
final class FirebaseCryptoModel {
  FirebaseCryptoModel({
    this.id,
    required this.cryptoId,
    required this.amount,
    required this.averagePrice,
    required this.totalInvested,
    required this.updatedAt,
    this.soldPositionAt,
    required this.lastTradeAt,
    required this.totalFee,
    required this.totalProfit,
    required this.user,
  });

  factory FirebaseCryptoModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseCryptoModelFromJson(json);

  factory FirebaseCryptoModel.fromWalletCrypto(WalletCrypto walletCrypto) =>
      FirebaseCryptoModel(
        id: walletCrypto.id,
        cryptoId: walletCrypto.cryptoId,
        amount: walletCrypto.amount,
        averagePrice: walletCrypto.averagePrice,
        totalInvested: walletCrypto.totalInvested,
        updatedAt: walletCrypto.updatedAt,
        soldPositionAt: walletCrypto.soldPositionAt,
        lastTradeAt: walletCrypto.lastTradeAt,
        totalFee: walletCrypto.totalFee,
        totalProfit: walletCrypto.totalProfit,
        user: walletCrypto.userId,
      );

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  final String cryptoId;
  final double amount;
  final double averagePrice;
  final double totalInvested;

  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime updatedAt;

  @JsonKey(fromJson: _dateNullableFromJson, toJson: _dateToJson)
  final DateTime? soldPositionAt;

  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime lastTradeAt;

  final double totalFee;
  final double totalProfit;
  final String user;

  static Timestamp? _dateToJson(DateTime? value) =>
      value != null ? Timestamp.fromDate(value) : null;

  static DateTime? _dateNullableFromJson(Timestamp? value) => value?.toDate();

  static DateTime _dateFromJson(Timestamp value) => value.toDate();

  Map<String, dynamic> toJson() => _$FirebaseCryptoModelToJson(this);

  WalletCrypto toWalletCrypto() => WalletCrypto(
        id: id,
        cryptoId: cryptoId,
        amount: amount,
        averagePrice: averagePrice,
        totalInvested: totalInvested,
        lastTradeAt: lastTradeAt,
        soldPositionAt: soldPositionAt,
        totalFee: totalFee,
        totalProfit: totalProfit,
        updatedAt: updatedAt,
        userId: user,
      );
}
