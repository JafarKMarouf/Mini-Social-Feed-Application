import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/build_media_content.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/post_header.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/post_media_slider.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 20),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
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
