import 'package:crypto_wallet/core/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:crypto_wallet/domain/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore extends _AppStore with _$AppStore {
  AppStore(super.authRepository);
}

abstract class _AppStore with Store {
  _AppStore(this._authRepository);

  final AuthRepository _authRepository;

  late final ObservableStream<AppUser?> userStream;

  final ObservableFuture<AppUser?> signInWithGoogleFuture =
      ObservableFuture.value(null);

  @observable
  int currentPageValue = 0;

  @computed
  BottomNavigationPage get currentPage =>
      BottomNavigationPage.fromIndex(currentPageValue);

  @action
  void changePage(int newPage) => currentPageValue = newPage;

  @action
  void listenUser() {
    userStream = ObservableStream(_authRepository.userChanges());
  }

  @action
  Future<void> signInWithGoogle() async {
    await _authRepository.signInWithGoogle();
    //   if (response != null) {
    //     stateStatus = PageStateStatus.success;
    //   } else {
    //     stateStatus = PageStateStatus.error;
    //     error = ExternalError(AppLocalizations.current.errorUnknowError);
    //   }
    // } on AppError catch (error) {
    //   stateStatus = PageStateStatus.error;
    //   this.error = error;
    // }
  }

  void dispose() {
    userStream.close();
  }
}
