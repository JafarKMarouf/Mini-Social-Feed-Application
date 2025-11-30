import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/core/utils/widgets/cached_image_helper/image_error.dart';
import 'package:mini_social_feed/core/utils/widgets/cached_image_helper/image_place_holder.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/media.dart';

class DisplayNetworkMediaGrid extends StatefulWidget {
  final List<Media> mediaList;
  final Function(Media media) onRemove;

  const DisplayNetworkMediaGrid({
    super.key,
    required this.mediaList,
    required this.onRemove,
  });

  @override
  State<DisplayNetworkMediaGrid> createState() =>
      _DisplayNetworkMediaGridState();
}

class _DisplayNetworkMediaGridState extends State<DisplayNetworkMediaGrid> {
  @override
  Widget build(BuildContext context) {
    int count = widget.mediaList.length;
    double screenWidth = MediaQuery.of(context).size.width - 32;
    double height = 300;

    return Container(
      height: height,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
        color: Colors.black12,
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildGridLayout(count),
    );
  }

  // --- Grid Layout Logic (Same as your local grid) ---
  Widget _buildGridLayout(int count) {
    if (count == 0) return const SizedBox();
    if (count == 1) {
      return _buildTile(0);
    } else if (count == 2) {
      return Row(
        children: [
          Expanded(child: _buildTile(0)),
          const SizedBox(width: 2),
          Expanded(child: _buildTile(1)),
        ],
      );
    } else if (count == 3) {
      return Row(
        children: [
          Expanded(child: _buildTile(0)),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              children: [
                Expanded(child: _buildTile(1)),
                const SizedBox(height: 2),
                Expanded(child: _buildTile(2)),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(flex: 2, child: _buildTile(0)),
          const SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: _buildTile(1)),
                const SizedBox(height: 2),
                Expanded(child: _buildTile(2)),
                const SizedBox(height: 2),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildTile(3),
                      if (count > 4)
                        Container(
                          color: Colors.black54,
                          alignment: Alignment.center,
                          child: Text(
                            '+${count - 4}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildTile(int index) {
    final media = widget.mediaList[index];
    final type = media.mediaType ?? 'document';

    Widget content;

    if (type == 'image') {
      content = CachedNetworkImage(
        imageUrl: media.url ?? '',
        fit: BoxFit.cover,
        placeholder: (context, url) => imagePlaceHolder(),
        errorWidget: (context, url, error) => imageError(),
      );
    } else if (type == 'video') {
      content = _buildVideoPlaceholder();
    } else {
      String ext = 'FILE';
      if (media.url != null) {
        ext = media.url!.split('.').last.split('?').first;
      }
      content = _buildDocumentPlaceholder(ext, type.toUpperCase());
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        content,
        // Remove Button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => widget.onRemove(media),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      color: AppColorManager.dark,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.videocam, size: 60, color: Colors.white.withOpacity(0.1)),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColorManager.gray, width: 2),
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentPlaceholder(String ext, String typeLabel) {
    return Container(
      color: AppColorManager.dark,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColorManager.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(
                  _getIconForExt(ext),
                  color: AppColorManager.primary,
                  size: 24,
                ),
                AppTextWidget(
                  text: ext.toUpperCase(),
                  style: AppTextStyle.styleUrbanistMedium15(context).copyWith(
                    color: AppColorManager.primary,
                    fontSize: FontSizeManager.fs12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppHeightManager.h1),
          AppTextWidget(
            text: typeLabel,
            style: AppTextStyle.styleUrbanistMedium15(context).copyWith(
              color: AppColorManager.white,
              fontSize: FontSizeManager.fs12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _getIconForExt(String ext) {
    switch (ext.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'txt':
        return Icons.text_snippet;
      case 'mp3':
      case 'wav':
        return Icons.audio_file;
      default:
        return Icons.insert_drive_file;
    }
  }
}
