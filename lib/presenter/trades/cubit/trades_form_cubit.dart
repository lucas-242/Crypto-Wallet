import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/models/enums/trade_operartion.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/domain/repositories/wallet_repository.dart';
import 'package:crypto_wallet/infra/services/cryptos_service.dart';
import 'package:equatable/equatable.dart';

part 'trades_form_state.dart';

class TradesFormCubit extends Cubit<TradesFormState> {
  TradesFormCubit(this._walletRepository, this._cryptosService)
      : super(TradesFormState());

  final WalletRepository _walletRepository;
  final CryptosService _cryptosService;

  void onChangeField({
    String? operationType,
    String? cryptoId,
    String? cryptoSymbol,
    double? amountDollars,
    double? fee,
    DateTime? date,
    String? user,
  }) =>
      emit(state.copyWith(
        trade: state.trade.copyWith(
          operationType: operationType,
          amountDollars: amountDollars,
          cryptoId: cryptoId,
          cryptoSymbol: cryptoSymbol,
          date: date,
          fee: fee,
          user: user,
        ),
      ));

  void onChangeAmount(String value) {
    final amount = double.tryParse(value) ?? 0;
    final amountDollars = amount * state.trade.price;

    emit(state.copyWith(
      trade: state.trade.copyWith(
        amount: amount,
        amountDollars: amountDollars,
      ),
    ));
  }

  void onChangePrice(String value) {
    final price = double.tryParse(value) ?? 0;
    final amountDollars = price * state.trade.amount;

    emit(state.copyWith(
      trade: state.trade.copyWith(
        price: price,
        amountDollars: amountDollars,
      ),
    ));
  }

  Future<void> onSave() async {
    try {
      await addTrade();
    } catch (error) {
      emit(state.copyWith(status: BaseStateStatus.error));
    }

    // return await addTrade(trade).then((value) {
    //   tradesBloc.getTrades(uid);
    //   walletBloc.getCryptos(uid);
    //   trade = TradeModel(user: uid);
    //   status = InsertTradeStatus();
    //   if (_interstitialAd.responseInfo != null) _interstitialAd.show();
    // }).catchError((error) {
    //   status = InsertTradeStatus.error(error.toString());
    //   throw Exception(error.toString());
    // });
  }

  Future<void> addTrade() async {
    final crypto = await _walletRepository.getCryptoById(state.trade.cryptoId);

    if (crypto == null) {
      return _addCryptoForTheFirstTime();
    }

    return _updateCrypto(crypto);
  }

  Future<void> _addCryptoForTheFirstTime() async {
    if (state.trade.operationType != TradeType.buy) {
      throw ClientError(AppLocalizations.current.errorInsufficientBalance);
    }

    final cryptoToCreate = WalletCrypto.fromTrade(state.trade);

    await _walletRepository.addTrade(
      TradeCreateOperation.create,
      state.trade,
      cryptoToCreate,
    );

    return;
  }

  Future<void> _updateCrypto(WalletCrypto crypto) async {
    late WalletCrypto updatedCrypto;

    final trade = _setTradeAccordingOperation(state.trade, crypto.averagePrice);

    //If this trade is before the last one or if it is the first trade after sold all position
    if ((trade.date.compareTo(crypto.lastTradeAt) < 0) ||
        (crypto.soldPositionAt != null && crypto.amount == 0)) {
      final otherTrades =
          await _walletRepository.getTrades(cryptoId: trade.cryptoId);
      updatedCrypto = _cryptosService.recalculatingWalletCrypto(
        crypto: crypto,
        trade: trade,
        trades: otherTrades,
      );
    } else {
      updatedCrypto = _cryptosService.setCryptoByOperation(crypto, trade);
    }

    await _walletRepository.addTrade(
        TradeCreateOperation.update, trade, updatedCrypto);
  }

  /// Set [trade]'s profit, price and amount dollars according to the operation type and the WalletCrypto [averagePrice]
  ///
  /// When transfering, the trade price is the average price, and the Amount in Dollars is calculated using the fee

  Trade _setTradeAccordingOperation(Trade trade, double averagePrice) {
    if (trade.operationType == TradeType.transfer) {
      return trade.copyWith(
        price: averagePrice,
        amountDollars: trade.fee,
      );
    }

    if (trade.operationType == TradeType.sell) {
      return trade.copyWith(
        profit: trade.amount * (trade.price - averagePrice),
      );
    }

    return trade;
  }
}
