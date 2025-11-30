import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/core/utils/widgets/cached_image_helper/image_error.dart';
import 'package:mini_social_feed/core/utils/widgets/cached_image_helper/image_place_holder.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/media.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/audio_player_post_view.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/video_player_post_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildMediaContent extends StatelessWidget {
  final Media media;

  const BuildMediaContent({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    if (media.url == null) {
      return const SizedBox.shrink();
    }
    switch (media.mediaType) {
      case 'image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: media.url!,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => imagePlaceHolder(),
            errorWidget: (context, url, error) => imageError(),
          ),
        );

      case 'video':
        return VideoPlayerPostView(videoUrl: media.url!);

      case 'audio':
        return AudioPlayerPostView(audioUrl: media.url!);

      case 'document':
        return Center(
          child: GestureDetector(
            onTap: () async {
              if (!await launchUrl(Uri.parse(media.url!))) {
                AppSnackBar.warning(context, AppLocalizations().canNotOpenDoc);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColorManager.darkGray,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColorManager.gray.withOpacity(.7)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.description,
                    color: AppColorManager.white,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppTextWidget(
                      text: media.url!.split('/').last,
                      style: AppTextStyle.styleUrbanistBold17(
                        context,
                      ).copyWith(color: AppColorManager.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.open_in_new, color: AppColorManager.white),
                ],
              ),
            ),
          ),
        );

      default:
        return Container(
          padding: const EdgeInsets.all(8),
          child: AppTextWidget(
            text: 'Unsupported Media Type: ${media.mediaType}',
            style: const TextStyle(color: AppColorManager.error),
          ),
        );
    }
  }
}
