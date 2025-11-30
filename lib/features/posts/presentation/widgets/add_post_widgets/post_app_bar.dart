import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

class PostAppBar extends StatelessWidget {
  final String title;
  final void Function()? publishPost;
  final void Function()? discard;

  const PostAppBar({
    super.key,
    this.publishPost,
    required this.discard,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColorManager.background,
      leadingWidth: 80,
      leading: Center(
        child: TextButton(
          onPressed: discard,
          child: Text(
            AppLocalizations().discard,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      title: AppTextWidget(
        text: title,
        style: AppTextStyle.styleUrbanistBold22(
          context,
        ).copyWith(color: AppColorManager.white),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: ElevatedButton(
              onPressed: publishPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF2D88),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                AppLocalizations().publish,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
