part of 'login_cubit.dart';

final class LoginState extends BaseState with EquatableMixin {
  const LoginState({
    required super.status,
    super.callbackMessage,
  });

  @override
  List<Object> get props => [
        status,
        callbackMessage,
      ];

  @override
  LoginState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
  }) =>
      LoginState(
        status: status ?? this.status,
        callbackMessage: callbackMessage ?? this.callbackMessage,
      );
}
