import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_social_feed/core/bloc/localization/locale_cubit.dart';
import 'package:mini_social_feed/core/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:mini_social_feed/core/network/api_service.dart';
import 'package:mini_social_feed/core/network/auth_interceptor.dart';
import 'package:mini_social_feed/core/routes/app_router.dart';
import 'package:mini_social_feed/core/services/secure_storage_service.dart';
import 'package:mini_social_feed/core/services/shared_preference_service.dart';
import 'package:mini_social_feed/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:mini_social_feed/features/auth/data/repositories/auth_repository.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:mini_social_feed/features/intro/presentation/cubit/splash_cubit.dart';
import 'package:mini_social_feed/features/posts/data/data_source/post_remote_data_source.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/create_post_cubit/create_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/delete_post_cubit/delete_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/edit_post_cubit/edit_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/post_list_cubit/post_list_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/show_post_cubit/show_post_cubit.dart';

import '../../features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  setupNetwork();
  getIt.registerLazySingleton<GoRouter>(() => AppRouter.instance);

  /// splash cubits
  getIt.registerLazySingleton(() => SplashCubit());

  /// navigation cubits
  getIt.registerFactory(() => NavigationCubit(0));

  await _registerConfigDependencies();

  _registerAuthDependencies();

  _registerPostDependencies();
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

void _registerPostDependencies() {
  /// Data sources
  /// remote
  getIt.registerFactory<PostRemoteDataSource>(() => PostRemoteDataSourceImpl());

  /// Repositories
  getIt.registerFactory<PostRepository>(() => PostRepositoryImpl());

  ///Cubits
  /// fetch post list cubit
  getIt.registerFactory(() => PostListCubit());

  /// fetch specific post cubit
  getIt.registerFactory(() => ShowPostCubit());

  /// create post cubit
  getIt.registerFactory(() => CreatePostCubit());

  /// edit post cubit
  getIt.registerFactory(() => EditPostCubit());

  /// delete post cubit
  getIt.registerFactory(() => DeletePostCubit());
}
