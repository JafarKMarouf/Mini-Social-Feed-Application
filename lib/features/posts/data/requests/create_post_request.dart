import 'dart:io';

import 'package:dio/dio.dart';

class CreatePostRequest {
  final String title;
  final String content;

  final List<File>? media;

  const CreatePostRequest({
    required this.title,
    required this.content,
    this.media,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'media': media?.map((e) => e.path).toList(),
    };
  }

  static Future<FormData> createFormData(CreatePostRequest request) async {
    final formData = FormData.fromMap({
      'title': request.title,
      'content': request.content,
    });
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
