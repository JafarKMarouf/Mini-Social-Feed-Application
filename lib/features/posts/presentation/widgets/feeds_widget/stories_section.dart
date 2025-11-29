import 'package:flutter/material.dart';
import 'package:mini_social_feed/features/posts/data/models/mock_data.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/story_card.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: mockStories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          return StoryCard(story: mockStories[index]);
        },
      ),
    );
  }
}
