part of 'wallet_cubit.dart';

final class WalletState extends BaseState with EquatableMixin {
  WalletState({
    super.status = BaseStateStatus.initial,
    super.callbackMessage,
    this.wallet = const Wallet(),
  });

  final Wallet wallet;

  @override
  List<Object> get props => [wallet];

  @override
  WalletState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    Wallet? wallet,
  }) =>
      WalletState(
        status: status ?? this.status,
        callbackMessage: callbackMessage ?? this.callbackMessage,
        wallet: wallet ?? this.wallet,
      );
}
