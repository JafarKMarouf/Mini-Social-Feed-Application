import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mini_social_feed/core/network/auth_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService(DioClient dioClient) : _dio = dioClient.dio;

  Future<Response> get({required String url}) async {
    var response = await _dio.get(url);
    return response;
  }

  Future<Response> post({
    required String url,
    dynamic body,
    String? token,
    bool requiresAuth = false,
    bool optionalAuth = false,
  }) async {
    Options options;
    log('url:$url');
    log('body:$body');
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
    final response = await _dio.post(url, data: body, options: options);
    return response;
  }

  Future<Response> patch({
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
    final response = await _dio.patch(url, data: body, options: options);
    return response;
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? body,
    String? token,
    bool requiresAuth = false,
    bool optionalAuth = false,
  }) async {
    final response = await _dio.delete(
      url,
      data: body,
      options: Options(
        headers: _headers(token),
        extra: {'requiresAuth': requiresAuth, 'optionalAuth': optionalAuth},
      ),
    );
    return response;
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
