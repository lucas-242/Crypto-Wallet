part of 'trades_form_cubit.dart';

final class TradesFormState extends BaseState with EquatableMixin {
  TradesFormState({
    super.status = BaseStateStatus.initial,
    super.callbackMessage,
    Trade? trade,
  }) : trade = trade ?? Trade();

  final Trade trade;

  @override
  List<Object> get props => [status, callbackMessage, trade];

  @override
  TradesFormState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    Trade? trade,
  }) =>
      TradesFormState(
        status: status ?? this.status,
        callbackMessage: callbackMessage ?? this.callbackMessage,
        trade: trade ?? this.trade,
      );
}
