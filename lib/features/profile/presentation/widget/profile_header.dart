import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:mini_social_feed/features/profile/presentation/widget/app_pattern_background.dart';
import 'package:mini_social_feed/features/profile/presentation/widget/app_user_info.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return SizedBox(
          width: AppWidthManager.w95,
          height: AppHeightManager.h18,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AppPatternBackground(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w8),
                child: AppUserInfo(
                  userName: state is ProfileSuccessState
                      ? state.data.data!.name
                      : 'اسم المستخدم',
                  emailAddress: state is ProfileSuccessState
                      ? state.data.data!.email
                      : 'john.doe@example.com',
                  imageSize: 50,
                  fontSize: FontSizeManager.fs17,
                  onEditTap: () {},
                  mode: AppUserInfoMode.detailed,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
