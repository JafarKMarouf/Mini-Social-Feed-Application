import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessState) {
              AppSnackBar.success(context, state.data.message);
            }
            if (state is ProfileFailureState) {
              AppSnackBar.error(context, state.errMsg);
            }
          },
        ),
        BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              AppNavigator.pushReplacementNamed(AppRoutePaths.login);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.read<LogoutCubit>().logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const Center(child: Text('Home view')),
      ),
    );
  }
}
