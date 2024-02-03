import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/data/local_storage.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:crypto_wallet/domain/models/enums/bottom_navigation_page.dart';
import 'package:crypto_wallet/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._localStorage, this._authRepository)
      : super(const AppState(status: BaseStateStatus.initial));

  final AuthRepository _authRepository;
  final LocalStorage _localStorage;

  late final StreamSubscription<AppUser?> _userSubscription;

  void changePage(int newPage) =>
      emit(state.copyWith(currentPageValue: newPage));

  void changeShowWalletValues() =>
      emit(state.copyWith(showWalletValues: !state.showWalletValues));

  void listenUser() {
    _userSubscription = _authRepository.user().listen((user) {
      _setLocalStorage(user);
      emit(state.copyWith(user: user));
    });
  }

  void _setLocalStorage(AppUser? user) {
    if (user != null) {
      _localStorage.setUser(user);
    } else {
      _localStorage.clear();
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
