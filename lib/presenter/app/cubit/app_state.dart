part of 'app_cubit.dart';

final class AppState extends BaseState with EquatableMixin {
  const AppState({
    required super.status,
    super.callbackMessage,
    this.currentPageValue = 0,
    this.user,
  });

  final int currentPageValue;
  final AppUser? user;

  BottomNavigationPage get currentPage =>
      BottomNavigationPage.fromIndex(currentPageValue);

  @override
  List<Object?> get props => [
        status,
        callbackMessage,
        currentPageValue,
        currentPage,
        user,
      ];

  @override
  AppState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    int? currentPageValue,
    AppUser? user,
  }) =>
      AppState(
        status: status ?? this.status,
        callbackMessage: callbackMessage ?? this.callbackMessage,
        currentPageValue: currentPageValue ?? this.currentPageValue,
        user: user ?? this.user,
      );
}
