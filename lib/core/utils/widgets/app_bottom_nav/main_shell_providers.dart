import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_social_feed/core/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/core/utils/widgets/app_bottom_nav/app_bottom_nav.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/post_list_cubit/post_list_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/show_post_cubit/show_post_cubit.dart';

class MainShellProviders extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellProviders({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<NavigationCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()..getMyInfos()),
        BlocProvider(create: (_) => getIt<ShowPostCubit>()),
        BlocProvider(create: (_) => getIt<PostListCubit>()..fetchPostList()),
        BlocProvider(create: (_) => getIt<LogoutCubit>()),
      ],
      child: AppBottomNav(navigationShell: navigationShell),
    );
  }
}
