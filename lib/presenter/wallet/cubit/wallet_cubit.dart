import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/data/cryptos.dart';
import 'package:crypto_wallet/domain/models/crypto.dart';
import 'package:crypto_wallet/domain/models/wallet.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/domain/repositories/market_data_repository.dart';
import 'package:crypto_wallet/domain/repositories/wallet_repository.dart';
import 'package:equatable/equatable.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(
    this._walletRepository,
    this._marketDataRepository,
  ) : super(WalletState());
  final WalletRepository _walletRepository;
  final MarketDataRepository _marketDataRepository;

  Future<void> getWalletData() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      var walletCryptos = await _walletRepository.getCryptos();
      final cryptoSymbols = _getSymbolsFromWalletCryptos(walletCryptos);

      final marketDataResponse =
          await _marketDataRepository.getMarketData(cryptoSymbols);
      walletCryptos =
          _mergeMarketDataReponse(marketDataResponse, walletCryptos);
      walletCryptos.sort((a, b) => b.totalNow.compareTo(a.totalNow));

      final wallet = Wallet(cryptos: walletCryptos);

      emit(state.copyWith(wallet: wallet, status: BaseStateStatus.success));
    } on AppError catch (error) {
      emit(
        state.copyWith(
          status: BaseStateStatus.error,
          callbackMessage: error.message,
        ),
      );
    }
  }

  List<String> _getSymbolsFromWalletCryptos(List<WalletCrypto> walletCryptos) {
    final ids = walletCryptos.map((e) => e.cryptoId);

    return Cryptos.supported
        .where((c) => ids.contains(c.id))
        .map((e) => e.symbol)
        .toList();
  }

  List<WalletCrypto> _mergeMarketDataReponse(
    List<Crypto> marketDataResponse,
    List<WalletCrypto> walletCryptos,
  ) {
    final response = <WalletCrypto>[];
    for (final crypto in walletCryptos) {
      final marketData =
          marketDataResponse.where((m) => m.id == crypto.cryptoId).firstOrNull;

      if (marketData != null) {
        response.add(crypto.copyWith(marketData: marketData));
      }
    }

    return response;
  }

  void onOpenCloseCryptoCard(String cryptoId) {
    final currentCryptos = state.wallet.cryptos;
    final updatedCryptos = currentCryptos
        .map((c) =>
            c.copyWith(isOpen: c.cryptoId == cryptoId ? !c.isOpen : false))
        .toList();

    emit(state.copyWith(wallet: Wallet(cryptos: updatedCryptos)));
  }
}
