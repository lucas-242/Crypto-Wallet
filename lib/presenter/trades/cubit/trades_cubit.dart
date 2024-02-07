import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/core/errors/errors.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/models/dropdown_item.dart';
import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/domain/repositories/wallet_repository.dart';
import 'package:equatable/equatable.dart';

part 'trades_state.dart';

class TradesCubit extends Cubit<TradesState> {
  TradesCubit(this._walletRepository) : super(const TradesState());

  final WalletRepository _walletRepository;

  Future<void> getTrades() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final trades = await _walletRepository.getTrades();
      emit(state.copyWith(status: BaseStateStatus.success, trades: trades));
    } on AppError catch (error) {
      emit(
        state.copyWith(
          status: BaseStateStatus.error,
          callbackMessage: error.message,
        ),
      );
    }
  }

  List<Trade> getTradesByDate(DateTime date) =>
      state.trades.where((element) => element.date == date).toList();

  List<Trade> filterTrades(DropdownItem? item) {
    if (item == null || item.value.isEmpty) {
      return state.trades;
    }
    return state.trades.where((e) => e.cryptoId == item.value).toList();
  }
}
