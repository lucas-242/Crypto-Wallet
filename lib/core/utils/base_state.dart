enum BaseStateStatus { loading, error, success, noData, initial }

class BaseState {
  const BaseState({required this.status, this.callbackMessage = ''});
  final BaseStateStatus status;
  final String callbackMessage;

  T when<T>({
    required T Function(BaseState state) onState,
    T Function(BaseState state)? onInitial,
    T Function(BaseState error)? onError,
    T Function()? onLoading,
    T Function()? onNoData,
  }) {
    switch (status) {
      case BaseStateStatus.loading:
        return onLoading != null ? onLoading() : onState(this);
      case BaseStateStatus.noData:
        return onNoData != null ? onNoData() : onState(this);
      case BaseStateStatus.error:
        return onError != null ? onError(this) : onState(this);
      case BaseStateStatus.initial:
        return onInitial != null ? onInitial(this) : onState(this);
      default:
        return onState(this);
    }
  }

  BaseState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
  }) {
    return BaseState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
    );
  }
}
