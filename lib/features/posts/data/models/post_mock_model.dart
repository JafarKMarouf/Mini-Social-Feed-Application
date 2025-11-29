class PostMockModel {
  final String userName;
  final String userAvatarUrl;
  final String timeAgo;
  final String? text;
  final String? postImageUrl;
  final String likes;
  final String comments;
  final String shares;

  const PostMockModel({
    required this.userName,
    required this.userAvatarUrl,
    required this.timeAgo,
    this.text,
    this.postImageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
