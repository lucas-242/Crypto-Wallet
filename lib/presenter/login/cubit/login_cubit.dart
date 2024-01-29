import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository)
      : super(const LoginState(status: BaseStateStatus.initial));

  final AuthRepository _authRepository;

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _authRepository.signInWithGoogle();
    emit(state.copyWith(status: BaseStateStatus.success));
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _authRepository.signOut();
    emit(state.copyWith(status: BaseStateStatus.success));
  }
}
