import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Center(child: AppTextWidget(text: 'Home view',color: AppColorManager.white,));
    // return MultiBlocListener(
    //   listeners: [
    //     BlocListener<ProfileCubit, ProfileState>(
    //       listener: (context, state) {
    //         if (state is ProfileSuccessState) {
    //           AppSnackBar.success(context, state.data.message);
    //         }
    //         if (state is ProfileFailureState) {
    //           AppSnackBar.error(context, state.errMsg);
    //         }
    //       },
    //     ),
    //     BlocListener<PostListCubit, PostListState>(
    //       listener: (context, state) {
    //         if (state is PostListSuccess) {
    //           AppSnackBar.success(context, 'Post List Fetched');
    //         }
    //         if (state is PostListFailure) {
    //           AppSnackBar.error(context, state.errMsg);
    //         }
    //       },
    //     ),
    //     BlocListener<ShowPostCubit, ShowPostState>(
    //       listener: (context, state) {
    //         if (state is ShowPostSuccess) {
    //           AppSnackBar.success(context, 'Post with id 2 Fetched');
    //         }
    //         if (state is ShowPostFailure) {
    //           AppSnackBar.error(context, state.errMsg);
    //         }
    //       },
    //     ),
    //     BlocListener<LogoutCubit, LogoutState>(
    //       listener: (context, state) {
    //         if (state is LogoutSuccess) {
    //           AppNavigator.pushReplacementNamed(AppRoutePaths.login);
    //         }
    //       },
    //     ),
    //   ],
    //   child: Scaffold(
    //     appBar: AppBar(
    //       actions: [
    //         IconButton(
    //           onPressed: () {
    //             context.read<LogoutCubit>().logout();
    //           },
    //           icon: const Icon(Icons.logout),
    //         ),
    //       ],
    //     ),
    //     body: ),
    //   ),
    // );
  }
}
