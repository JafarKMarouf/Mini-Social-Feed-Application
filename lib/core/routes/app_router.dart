import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mini_social_feed/core/constants/app_constant_manager.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/views/login/login_view.dart';
import 'package:mini_social_feed/features/auth/presentation/views/register/register_view.dart';
import 'package:mini_social_feed/features/intro/presentation/cubit/splash_cubit.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/onboarding_view.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/splash_view.dart';
import 'package:mini_social_feed/features/posts/presentation/pages/home_view.dart';

abstract class AppRouter {
  static final routes = [
    GetPage(
      name: AppRoutePaths.splash,
      page: () {
        return BlocProvider(
          create: (_) => getIt<SplashCubit>()..checkAppStatus(),
          child: const SplashView(),
        );
      },
      transitionDuration: AppConstantManager.kTransitionDuration,
      transition: AppConstantManager.kTransition,
    ),
    GetPage(
      name: AppRoutePaths.onboarding,
      page: () => const OnBoardingView(),
      transitionDuration: AppConstantManager.kTransitionDuration,
      transition: AppConstantManager.kTransition,
    ),

    GetPage(
      name: AppRoutePaths.login,
      page: () {
        return BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginView(),
        );
      },
      transitionDuration: AppConstantManager.kTransitionDuration,
      transition: AppConstantManager.kTransition,
    ),
    GetPage(
      name: AppRoutePaths.register,
      page: () {
        return BlocProvider(
          create: (_) => getIt<RegisterCubit>(),
          child: const RegisterView(),
        );
      },
      transitionDuration: AppConstantManager.kTransitionDuration,
      transition: AppConstantManager.kTransition,
    ),

    GetPage(
      name: AppRoutePaths.home,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<LogoutCubit>()),
            BlocProvider(create: (_) => getIt<ProfileCubit>()..getMyInfos()),
          ],
          child: const HomeView(),
        );
      },
      transitionDuration: AppConstantManager.kTransitionDuration,
      transition: AppConstantManager.kTransition,
    ),
  ];
}
