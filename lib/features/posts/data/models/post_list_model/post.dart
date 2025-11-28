import 'package:equatable/equatable.dart';

import 'media.dart';
import 'user.dart';

class Post extends Equatable {
  final int? id;
  final String? title;
  final String? content;
  final User? user;
  final List<Media>? media;
  final String? createdAt;
  final String? updatedAt;

  const Post({
    this.id,
    this.title,
    this.content,
    this.user,
    this.media,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'] as int?,
    title: json['title'] as String?,
    content: json['content'] as String?,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    media: (json['media'] as List<dynamic>?)
        ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'user': user?.toJson(),
    'media': media?.map((e) => e.toJson()).toList(),
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  @override
  List<Object?> get props {
    return [id, title, content, user, media, createdAt, updatedAt];
  }
}
