import 'package:flutter/material.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/media.dart'; // Adjust path
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/build_media_content.dart'; // Adjust path
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/utils/resources/app_color_manager.dart';
import '../../../../../core/utils/resources/size_manager.dart';

class PostMediaSlider extends StatefulWidget {
  final List<Media> mediaList;

  const PostMediaSlider({super.key, required this.mediaList});

  @override
  State<PostMediaSlider> createState() => _PostMediaSliderState();
}

class _PostMediaSliderState extends State<PostMediaSlider> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getHeightForIndex(int index) {
    final media = widget.mediaList[index];

    switch (media.mediaType) {
      case 'image':
      case 'video':
        return AppHeightManager.h27;
      case 'document':
      case 'audio':
        return 80.0;
      default:
        return 50.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _getHeightForIndex(_currentIndex),
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.mediaList.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BuildMediaContent(media: widget.mediaList[index]),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        if (widget.mediaList.length > 1)
          SmoothPageIndicator(
            controller: _controller,
            count: widget.mediaList.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: AppColorManager.primary,
              dotColor: AppColorManager.gray,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 6,
            ),
            onDotClicked: (index) {
              _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
      ],
    );
  }
}
