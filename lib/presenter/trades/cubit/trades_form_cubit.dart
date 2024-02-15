import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/models/crypto.dart';
import 'package:crypto_wallet/domain/models/enums/trade_operartion.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/domain/repositories/wallet_repository.dart';
import 'package:equatable/equatable.dart';

part 'trades_form_state.dart';

class TradesFormCubit extends Cubit<TradesFormState> {
  TradesFormCubit(this._walletRepository) : super(TradesFormState());

  final WalletRepository _walletRepository;

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

  Future<void> onSave({required String uid}) async {
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

    return _addCrypto();
  }

  Future<void> _addCryptoForTheFirstTime() async {
    if (state.trade.operationType != TradeType.buy) {
      throw ClientError(AppLocalizations.current.errorInsufficientBalance);
    }

    final cryptoToCreate = _cryptosService.setCryptoForTheFirstTime(trade);

    await _walletRepository.addTrade(
        TradeCreateOperation.create, trade, cryptoToCreate);

    return;
  }

  Future<void> _addCrypto() async {
    late Crypto updatedCrypto;

    //Check if the type of trade to set some properties
    trade = setTrade(trade, crypto.averagePrice);

    //If this trade is before the last one or if it is the first trade after sold all position
    if ((trade.date.compareTo(crypto.lastTradeAt) < 0) ||
        (crypto.soldPositionAt != null && crypto.amount == 0)) {
      final otherTrades = await _walletRepository.getTrades(trade.user!,
          cryptoId: trade.cryptoId);
      updatedCrypto = _cryptosService.recalculatingCryptoProperties(
          crypto, trade, otherTrades);
    } else {
      updatedCrypto = _cryptosService.calculateCryptoProperties(crypto, trade);
    }

    await _walletRepository.addTrade(
        TradeCreateOperation.update, trade, updatedCrypto);
  }
}
