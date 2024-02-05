part of 'trades_cubit.dart';

final class TradesState extends BaseState with EquatableMixin {
  const TradesState({
    super.status = BaseStateStatus.initial,
    super.callbackMessage,
    this.trades = const [],
  });

  final List<Trade> trades;

  @override
  List<Object> get props => [
        status,
        callbackMessage,
        trades,
      ];

  @override
  TradesState copyWith(
          {BaseStateStatus? status,
          String? callbackMessage,
          List<Trade>? trades}) =>
      TradesState(
        status: status ?? this.status,
        callbackMessage: callbackMessage ?? this.callbackMessage,
        trades: trades ?? this.trades,
      );
}
