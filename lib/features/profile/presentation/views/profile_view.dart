import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';
import 'package:mini_social_feed/core/utils/widgets/change_lang_loading/change_lang_loading.dart';
import 'package:mini_social_feed/core/utils/widgets/loading/loading_overlay.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:mini_social_feed/features/profile/presentation/widget/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              AppNavigator.pushReplacementNamed(AppRoutePaths.login);
            }
            if (state is LogoutFailure) {
              AppSnackBar.error(context, state.errMsg);
            }
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailureState) {
              AppSnackBar.error(context, state.errMsg);
            }
          },
        ),
      ],
      child: SafeArea(
        child: Stack(
          children: [
            const ProfileViewBody(),
            BlocBuilder<LogoutCubit, LogoutState>(
              builder: (context, state) {
                return buildLoadingOverlay(state is LogoutLoading);
              },
            ),
            const ChangeLangLoading(),
          ],
        ),
      ),
    );
  }
}
