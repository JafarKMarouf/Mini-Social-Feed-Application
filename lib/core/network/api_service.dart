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
    Options options;
    if (body is FormData) {
      options = Options(
        headers: _headers(token, isFormData: true),
        extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
      );
    } else {
      options = Options(
        headers: _headers(token),
        extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
      );
    }
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
    Options options;
    if (body is FormData) {
      options = Options(
        headers: _headers(token, isFormData: true),
        extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
      );
    } else {
      options = Options(
        headers: _headers(token),
        extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
      );
    }
    return await _dio.put(url, data: body, options: options);
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? body,
    String? token,
    bool requiresAuth = false,
    bool optionalAuth = false,
  }) async {
    log('===============delete url:$url');
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

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
