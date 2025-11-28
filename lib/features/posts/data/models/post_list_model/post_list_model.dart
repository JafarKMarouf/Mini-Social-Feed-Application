import 'package:equatable/equatable.dart';

import 'pagination.dart';
import 'post.dart';

class PostListModel extends Equatable {
  final List<Post>? posts;
  final Pagination? pagination;

  const PostListModel({this.posts, this.pagination});

  factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
    posts: (json['posts'] as List<dynamic>?)
        ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList(),
    pagination: json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'posts': posts?.map((e) => e.toJson()).toList(),
    'pagination': pagination?.toJson(),
  };

  @override
  List<Object?> get props => [posts, pagination];
}
