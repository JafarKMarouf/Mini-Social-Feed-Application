import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_social_feed/core/bloc/localization/locale_cubit.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/image_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/features/intro/presentation/cubit/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final localeCubit = context.read<LocaleCubit>();

    await Future.wait([localeCubit.setInitialLocale()]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashUnAuthenticated) {
          AppNavigator.pushReplacementNamed(AppRoutePaths.onboarding);
        }
        if (state is SplashAuthenticated) {
          AppNavigator.pushReplacementNamed(AppRoutePaths.home);
        }
      },
      child: Scaffold(
        backgroundColor: AppColorManager.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                width: 90,
                height: 90,
                AppImageManager.branding,
                fit: BoxFit.fill,
              ),
              SizedBox(height: AppHeightManager.h2),

              SvgPicture.asset(
                AppImageManager.logo,
                colorFilter: const ColorFilter.mode(
                  AppColorManager.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
