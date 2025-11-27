import 'package:get_it/get_it.dart';
import 'package:mini_social_feed/core/bloc/localization/locale_cubit.dart';
import 'package:mini_social_feed/core/network/api_service.dart';
import 'package:mini_social_feed/core/network/auth_interceptor.dart';
import 'package:mini_social_feed/core/services/secure_storage_service.dart';
import 'package:mini_social_feed/core/services/shared_preference_service.dart';
import 'package:mini_social_feed/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:mini_social_feed/features/auth/data/repositories/auth_repository.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:mini_social_feed/features/intro/presentation/cubit/splash_cubit.dart';

import '../../features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  setupNetwork();

  /// splash cubits
  getIt.registerLazySingleton(() => SplashCubit());

  await _registerConfigDependencies();

  _registerAuthDependencies();
}

void setupNetwork() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<DioClient>()));
}

Future<void> _registerConfigDependencies() async {
  getIt.registerLazySingleton<SharedPreferenceService>(
    () => SharedPreferenceService(),
  );
  await getIt<SharedPreferenceService>().init();

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  /// Cubits
  /// Localization
  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit(getIt()));
  await getIt<LocaleCubit>().setInitialLocale();
}

void _registerAuthDependencies() {
  /// Data sources
  /// remote
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  /// Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  ///Cubits
  /// login cubit
  getIt.registerFactory(() => LoginCubit());

  /// register cubit
  getIt.registerFactory(() => RegisterCubit());

  /// logout cubit
  getIt.registerFactory(() => LogoutCubit());

  /// profile cubit
  getIt.registerFactory(() => ProfileCubit());
}
