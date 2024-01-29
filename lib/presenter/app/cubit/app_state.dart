part of 'app_cubit.dart';

final class AppState extends BaseState with EquatableMixin {
  const AppState({
    required super.status,
    super.callbackMessage,
    this.currentPageValue = 0,
    this.user,
    this.showWalletValues = false,
  });

  final int currentPageValue;
  final AppUser? user;
  final bool showWalletValues;

  BottomNavigationPage get currentPage =>
      BottomNavigationPage.fromIndex(currentPageValue);

  @override
  List<Object?> get props => [
        status,
        callbackMessage,
        currentPageValue,
        currentPage,
        user,
        showWalletValues,
      ];

  @override
  AppState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    int? currentPageValue,
    AppUser? user,
    bool? showWalletValues,
  }) =>
      AppState(
        status: status ?? this.status,
        callbackMessage: callbackMessage ?? this.callbackMessage,
        currentPageValue: currentPageValue ?? this.currentPageValue,
        user: user ?? this.user,
        showWalletValues: showWalletValues ?? this.showWalletValues,
      );
}
