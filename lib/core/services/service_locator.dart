import 'package:get_it/get_it.dart';
import 'package:mini_social_feed/core/bloc/localization/locale_cubit.dart';
import 'package:mini_social_feed/core/services/secure_storage_service.dart';
import 'package:mini_social_feed/core/services/shared_preference_service.dart';
import 'package:mini_social_feed/features/intro/presentation/cubit/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
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

  /// splash cubit
  getIt.registerLazySingleton(() => SplashCubit());
}
