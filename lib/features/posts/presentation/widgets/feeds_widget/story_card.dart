import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/features/posts/data/models/story_mock_model.dart';

class StoryCard extends StatelessWidget {
  final StoryMockModel story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: AppWidthManager.w32,
          height: AppHeightManager.h20,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(story.storyImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        CachedNetworkImage(
          imageUrl: story.storyImageUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: 140,
            height: 200,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => Container(
            width: 140,
            height: 200,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: AppColorManager.darkGray,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColorManager.primary,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: 140,
            height: 200,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.error, color: Colors.grey),
          ),
        ),

        Positioned.fill(
          bottom: 15,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColorManager.dark],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColorManager.primary, width: 2),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: CachedNetworkImageProvider(
                  story.userAvatarUrl,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
