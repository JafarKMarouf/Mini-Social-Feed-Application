import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/onboarding_view.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/splash_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePaths.splash,
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('404 - Page Not Found'))),

  routes: <RouteBase>[
    GoRoute(
      path: AppRoutePaths.splash,
      name: AppRouteNames.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutePaths.onboarding,
      name: AppRouteNames.onboarding,
      builder: (context, state) => const OnBoardingView(),
    ),
  ],
);
