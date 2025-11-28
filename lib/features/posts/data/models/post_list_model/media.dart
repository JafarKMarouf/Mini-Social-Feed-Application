import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final int? id;
  final String? mediaType;
  final String? url;
  final String? filePath;

  const Media({this.id, this.mediaType, this.url, this.filePath});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json['id'] as int?,
    mediaType: json['media_type'] as String?,
    url: json['url'] as String?,
    filePath: json['file_path'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'media_type': mediaType,
    'url': url,
    'file_path': filePath,
  };

  @override
  List<Object?> get props => [id, mediaType, url, filePath];
}
