import 'package:crypto_wallet/domain/data/local_storage.dart';
import 'package:crypto_wallet/domain/repositories/auth_repository.dart';
import 'package:crypto_wallet/domain/repositories/market_data_repository.dart';
import 'package:crypto_wallet/domain/repositories/wallet_repository.dart';
import 'package:crypto_wallet/domain/services/cryptos_services.dart';
import 'package:crypto_wallet/firebase_options.dart';
import 'package:crypto_wallet/infra/local_storage/shared_preferences/shared_preferences_local_storage.dart';
import 'package:crypto_wallet/infra/repositories/auth_repository/firebase/firebase_auth_repository.dart';
import 'package:crypto_wallet/infra/repositories/market_data_repository/mobula/mobula_market_data_repository.dart';
import 'package:crypto_wallet/infra/repositories/wallet_repository/firebase/firebase_wallet_repository.dart';
import 'package:crypto_wallet/infra/services/local_cryptos_service.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/presenter/login/cubit/login_cubit.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_cubit.dart';
import 'package:crypto_wallet/presenter/wallet/cubit/wallet_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ServiceLocator {
  static final _instance = GetIt.instance;

  static T get<T extends Object>() => _instance.get<T>();

  static Future<void> init() async {
    await _initFirebase();
    await _initStorages();
    _initServices();
    _initRepositories();
    _initBlocs();
  }

  static Future<void> _initFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> _initStorages() async {
    _instance.registerSingleton<LocalStorage>(
      SharedPreferencesLocalStorage(await SharedPreferences.getInstance()),
    );
  }

  static Future<void> _initServices() async {
    _instance.registerFactory<CryptosService>(() => LocalCryptosService());
  }

  static void _initRepositories() {
    _instance.registerFactory<AuthRepository>(() => FirebaseAuthRepository());

    _instance.registerFactory<WalletRepository>(
      () => FirebaseWalletRepository(
        localStorage: _instance.get<LocalStorage>(),
      ),
    );

    _instance.registerFactory<MarketDataRepository>(
      () => MobulaMarketDataRepository(),
    );
  }

  static void _initBlocs() {
    _instance.registerSingleton(AppCubit(
      _instance.get<LocalStorage>(),
      _instance.get<AuthRepository>(),
    ));

    _instance.registerSingleton(WalletCubit(
      _instance.get<WalletRepository>(),
      _instance.get<MarketDataRepository>(),
    ));

    _instance.registerSingleton(TradesCubit(
      _instance.get<WalletRepository>(),
    ));

    _instance
        .registerFactory(() => LoginCubit(_instance.get<AuthRepository>()));
  }
}
