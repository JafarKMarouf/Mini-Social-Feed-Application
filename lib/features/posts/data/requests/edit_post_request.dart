import 'dart:io';

import 'package:dio/dio.dart';

class EditPostRequest {
  final String id;
  final String? title;
  final String? content;
  final List<int>? removedMediaIds;
  final List<File>? media;

  const EditPostRequest({
    required this.id,
    this.title,
    this.content,
    this.removedMediaIds,
    this.media,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'remove_media_ids': removedMediaIds?.map((e) => e.toInt()).toList(),
      'media': media?.map((e) => e.path).toList(),
    };
  }

  static Future<FormData> createFormData(EditPostRequest request) async {
    final Map<String, dynamic> map = {};
    final formData = FormData.fromMap(map);

    if (request.title != null) map['title'] = request.title;
    if (request.content != null) map['content'] = request.content;

    if (request.removedMediaIds != null &&
        request.removedMediaIds!.isNotEmpty) {
      for (var id in request.removedMediaIds!) {
        formData.fields.add(MapEntry('remove_media_ids[]', id.toString()));
      }
    }

    if (request.media != null && request.media!.isNotEmpty) {
      for (final file in request.media!) {
        formData.files.add(
          MapEntry(
            'media',
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }
    }
    return formData;
  }
}
