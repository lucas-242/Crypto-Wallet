part of 'trades_cubit.dart';

final class TradesState extends BaseState with EquatableMixin {
  const TradesState({
    super.status = BaseStateStatus.initial,
    super.callbackMessage,
    this.trades = const [],
    this.selectedTrade,
  });

  final List<Trade> trades;
  final Trade? selectedTrade;

  List<DateTime> get dates => trades.map((e) => e.date).toList();

  @override
  List<Object> get props => [
        status,
        callbackMessage,
        trades,
      ];

  @override
  TradesState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<Trade>? trades,
    Trade? selectedTrade,
  }) =>
      TradesState(
        status: status ?? this.status,
        callbackMessage: callbackMessage ?? this.callbackMessage,
        trades: trades ?? this.trades,
        selectedTrade: selectedTrade ?? this.selectedTrade,
      );
}
