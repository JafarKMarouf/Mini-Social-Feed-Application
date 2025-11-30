import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/utils/helper/app_alert_dialog.dart';
import 'package:mini_social_feed/core/utils/helper/format_date.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/delete_post_cubit/delete_post_cubit.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({super.key, required this.post});

  void _showDeletePostDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (contextBuilder) => appAlertDialog(
        contextBuilder,
        title: AppLocalizations().deletePost,
        subTitle: AppLocalizations().deletePostConfirm,
        icon: Icons.delete,
        color: AppColorManager.error,
        onPressed: () {
          AppNavigator.pop();
          _performDeletePost(context);
        },
      ),
    );
  }

  Future<void> _performDeletePost(BuildContext context) async {
    await context.read<DeletePostCubit>().deletePost(postId: post.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: CachedNetworkImageProvider(
            'https://i.pravatar.cc/150?u=10',
          ),
        ),
        SizedBox(width: AppWidthManager.w3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: post.user!.name ?? '',
              style: AppTextStyle.styleUrbanistBold17(context).copyWith(
                color: AppColorManager.white,
                fontSize: FontSizeManager.fs16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            AppTextWidget(
              text: formatStandardDate(post.createdAt),
              style: AppTextStyle.styleUrbanistMedium16(context).copyWith(
                color: Colors.grey[500],
                fontSize: FontSizeManager.fs15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),

        PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          color: AppColorManager.dark,
          icon: Icon(Icons.more_vert, color: Colors.grey[500]),
          onSelected: (value) {
            if (value == 'edit') {
              AppNavigator.pushNamed(
                AppRouteNames.editPost,
                pathParameters: {'id': post.id.toString()},
              );
            } else if (value == 'delete') {
              _showDeletePostDialog(context);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'edit',
                child: AppTextWidget(
                  text: AppLocalizations().editPost,
                  color: AppColorManager.white,
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: AppTextWidget(
                  text: AppLocalizations().deletePost,
                  color: AppColorManager.white,
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
