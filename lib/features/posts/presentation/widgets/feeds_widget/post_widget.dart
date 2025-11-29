import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/utils/helper/app_alert_dialog.dart';
import 'package:mini_social_feed/core/utils/helper/format_date.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/delete_post_cubit/delete_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/build_media_content.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/post_media_slider.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

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
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    // Handle Edit Logic
                  } else if (value == 'delete') {
                    _showDeletePostDialog(context);
                  } else if (value == 'copy') {
                    // Handle Share Logic
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
                      value: 'copy',
                      child: AppTextWidget(
                        text: AppLocalizations().copyLink,
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
          ),
          SizedBox(height: AppHeightManager.h2),
          if (post.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppTextWidget(
                text: post.title!,
                style: AppTextStyle.styleUrbanistSemiBold15(
                  context,
                ).copyWith(color: AppColorManager.inputFillColor, height: 1.4),
                maxLines: 5,
              ),
            ),

          if (post.content != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppTextWidget(
                text: post.content!,
                style: AppTextStyle.styleUrbanistSemiBold15(
                  context,
                ).copyWith(color: AppColorManager.inputFillColor, height: 1.4),
                maxLines: 5,
              ),
            ),

          if (post.media != null && post.media!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: post.media!.length == 1
                  ? BuildMediaContent(media: post.media!.first)
                  : PostMediaSlider(mediaList: post.media!),
            ),

          SizedBox(height: AppHeightManager.h2),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _ActionButton(icon: Icons.thumb_up_outlined, label: '2,245'),
                  SizedBox(width: 20),
                  _ActionButton(icon: Icons.chat_bubble_outline, label: '45'),
                  SizedBox(width: 20),
                  _ActionButton(icon: Icons.share_outlined, label: '124'),
                ],
              ),
              Icon(Icons.bookmark_border, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey[850]),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[400]),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
      ],
    );
  }
}
