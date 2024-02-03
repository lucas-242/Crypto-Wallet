import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:equatable/equatable.dart';

final class Wallet extends Equatable {
  const Wallet({this.cryptos = const []});

  double get totalNow => cryptos
      .map((e) => e.totalNow)
      .fold(0, (previousValue, element) => previousValue + element);

  double get totalInvested => cryptos
      .map((e) => e.totalInvested)
      .fold(0, (previousValue, element) => previousValue + element);

  double get variation => cryptos
      .map((e) => e.gainLoss)
      .fold(0, (previousValue, element) => previousValue + element);

  double get percentVariation => (variation.abs() * 100) / totalNow;

  final List<WalletCrypto> cryptos;

  double getpercentInWallet(String cryptoId) {
    final crypto = cryptos.where((c) => c.id == cryptoId).firstOrNull;
    if (crypto == null) return 0;

    return (crypto.totalNow * 100) / totalNow;
  }

  @override
  List<Object?> get props => [
        totalNow,
        totalInvested,
        variation,
        percentVariation,
      ];
}
