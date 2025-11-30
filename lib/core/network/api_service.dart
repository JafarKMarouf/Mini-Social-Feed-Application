import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mini_social_feed/core/network/auth_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService(DioClient dioClient) : _dio = dioClient.dio;

  Future<Response> get({
    required String url,
    String? token,
    bool requiresAuth = false,
    bool optionalAuth = false,
  }) async {
    Options options = Options(
      headers: _headers(token),
      extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
    );
    return await _dio.get(url, options: options);
  }

  Future<Response> post({
    required String url,
    dynamic body,
    String? token,
    bool requiresAuth = false,
    bool optionalAuth = false,
  }) async {
    log('┌────────────────────────────── post url: $url ──────────────────────────────');

    if (body is FormData) {
      logFormData(body);
    }
    final options = Options(
      headers: _headers(token, isFormData: body is FormData),
      extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
    );
    var response = await _dio.post(url, data: body, options: options);
    return response;
  }

  Future<Response> put({
    required String url,
    dynamic body,
    String? token,
    bool requiresAuth = false,
    bool optionalAuth = false,
  }) async {
    log('┌────────────────────────────── put url: $url ──────────────────────────────');
    if (body is FormData) {
      logFormData(body);
    }
    final options = Options(
      headers: _headers(token, isFormData: body is FormData),
      extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
    );

    return await _dio.put(url, data: body, options: options);
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? body,
    String? token,
    bool requiresAuth = false,
    bool optionalAuth = false,
  }) async {
    return await _dio.delete(
      url,
      data: body,
      options: Options(
        headers: _headers(token),
        extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
      ),
    );
  }

  Map<String, dynamic> _headers(String? token, {bool isFormData = false}) {
    final headers = <String, dynamic>{};
    if (!isFormData) {
      headers['Content-Type'] = 'application/json';
    }
    if (isFormData) {
      headers['Content-Type'] = 'multipart/form-data';
    }

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    headers['Accept'] = 'application/json';
    return headers;
  }
}

void logFormData(FormData formData) {
  log('┌──────────────────────────────────────────────────────────────────');
  log('│ 📋 FORM DATA LOG');
  log('├──────────────────────────────────────────────────────────────────');

  // 1. Log Text Fields
  if (formData.fields.isEmpty) {
    log('│ 📝 Fields: [EMPTY]');
  } else {
    log('│ 📝 Fields:');
    for (var field in formData.fields) {
      log('│    • ${field.key}: ${field.value}');
    }
  }

  log('│');

  // 2. Log Files
  if (formData.files.isEmpty) {
    log('│ 📁 Files: [EMPTY]');
  } else {
    log('│ 📁 Files:');
    for (var file in formData.files) {
      // file.value is MultipartFile
      log('│    • Key: "${file.key}"');
      log('│      Filename: ${file.value.filename}');
      log('│      Size: ${file.value.length} bytes');
      log('│      Content-Type: ${file.value.contentType}');
    }
  }
  log('└──────────────────────────────────────────────────────────────────');
}
