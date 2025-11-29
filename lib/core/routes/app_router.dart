import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_social_feed/core/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/widgets/app_bottom_nav/app_bottom_nav.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/core/utils/widgets/custom_transition_page/custom_transition_page.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/views/login_view.dart';
import 'package:mini_social_feed/features/auth/presentation/views/register_view.dart';
import 'package:mini_social_feed/features/intro/presentation/cubit/splash_cubit.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/onboarding_view.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/splash_view.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/create_post_cubit/create_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/delete_post_cubit/delete_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/post_list_cubit/post_list_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/pages/add_post_view.dart';
import 'package:mini_social_feed/features/posts/presentation/pages/feeds_view.dart';
import 'package:mini_social_feed/features/profile/presentation/views/profile_view.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static GoRouter get instance => router;
  static GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutePaths.splash,
    routes: [
      GoRoute(
        path: AppRoutePaths.splash,
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (_) => getIt<SplashCubit>()..checkAppStatus(),
            child: const SplashView(),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.onboarding,
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: const OnBoardingView(),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.login,

        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.register,
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: const RegisterView(),
          ),
        ),
      ),

      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) {
          return buildPageWithTransition(
            context: context,
            state: state,
            child: BlocProvider(
              create: (context) => getIt<NavigationCubit>()..setIndex(0),
              child: AppBottomNav(navigationShell: navigationShell),
            ),
          );
        },

        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutePaths.home,
                name: AppRouteNames.home,
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => PostListCubit()),
                      BlocProvider(create: (_) => DeletePostCubit()),
                    ],
                    child: const FeedsView(),
                  ),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutePaths.chat,
                name: AppRouteNames.chat,
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: const Scaffold(body: Center(child: Text('Chat'))),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutePaths.create,
                name: AppRouteNames.create,
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: BlocProvider(
                    create: (_) => getIt<CreatePostCubit>(),
                    child: const Scaffold(
                      backgroundColor: AppColorManager.background,
                      body: AddPostView(),
                    ),
                  ),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutePaths.alert,
                name: AppRouteNames.alert,
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: const Scaffold(body: Center(child: Text('Alert'))),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutePaths.profile,
                name: AppRouteNames.profile,
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => getIt<ProfileCubit>()..getMyInfos(),
                      ),
                      BlocProvider(create: (_) => getIt<LogoutCubit>()),
                    ],
                    child: const ProfileView(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      backgroundColor: AppColorManager.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Center(
          child: AppTextWidget(
            text: 'Error: ${state.error}',
            style: AppTextStyle.styleUrbanistBold22(
              context,
            ).copyWith(color: AppColorManager.white),
            maxLines: 3,
          ),
        ),
      ),
    ),
  );
}
