import 'package:mini_social_feed/features/posts/data/models/post_mock_model.dart';
import 'package:mini_social_feed/features/posts/data/models/story_mock_model.dart';

final List<StoryMockModel> mockStories = [
  const StoryMockModel(
    userAvatarUrl: 'https://i.pravatar.cc/150?u=1',
    storyImageUrl: 'https://picsum.photos/400/600?random=1',
  ),
  const StoryMockModel(
    userAvatarUrl: 'https://i.pravatar.cc/150?u=2',
    storyImageUrl: 'https://picsum.photos/400/600?random=2',
  ),
  const StoryMockModel(
    userAvatarUrl: 'https://i.pravatar.cc/150?u=3',
    storyImageUrl: 'https://picsum.photos/400/600?random=3',
  ),
  const StoryMockModel(
    userAvatarUrl: 'https://i.pravatar.cc/150?u=4',
    storyImageUrl: 'https://picsum.photos/400/600?random=4',
  ),
];

final List<PostMockModel> mockPosts = [
  const PostMockModel(
    userName: 'Jacob Washington',
    userAvatarUrl: 'https://i.pravatar.cc/150?u=10',
    timeAgo: '20m ago',
    text:
        '“If you think you are too small to make a difference, try sleeping with a mosquito.”\n~ Dalai Lama',
    likes: '2,245',
    comments: '45',
    shares: '124',
  ),
  const PostMockModel(
    userName: 'Kat Williams',
    userAvatarUrl: 'https://i.pravatar.cc/150?u=11',
    timeAgo: '1h ago',
    postImageUrl: 'https://picsum.photos/800/500?random=10',
    likes: '1,092',
    comments: '32',
    shares: '88',
  ),
  const PostMockModel(
    userName: 'Tony Stark',
    userAvatarUrl: 'https://i.pravatar.cc/150?u=12',
    timeAgo: '2h ago',
    text: 'Just built a new suit. Might delete later.',
    postImageUrl: 'https://picsum.photos/800/500?random=11',
    // Tech
    likes: '3M',
    comments: '50k',
    shares: '12k',
  ),
];
