import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/core/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:crypto_wallet/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._authRepository)
      : super(const AppState(status: BaseStateStatus.initial));

  final AuthRepository _authRepository;

  late final StreamSubscription<AppUser?> _userSubscription;

  void changePage(int newPage) =>
      emit(state.copyWith(currentPageValue: newPage));

  void listenUser() {
    _userSubscription = _authRepository.user().listen((user) {
      emit(state.copyWith(user: user));
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
