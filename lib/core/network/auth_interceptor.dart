import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mini_social_feed/core/constants/api_endpoints.dart';
import 'package:mini_social_feed/core/constants/app_constant_manager.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/services/secure_storage_service.dart';

import '../../features/auth/data/models/login_data.dart';

class DioClient {
  late final Dio dio;
  static const int _maxRetries = 2;
  bool _isRefreshing = false;
  Completer<bool>? _refreshTokenCompleter;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 400,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await SecureStorageService.getAccessToken();
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 500) {
            return _handleUnauthorizedError(error, handler);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _handleUnauthorizedError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final int retryCount = error.requestOptions.extra['retry_count'] ?? 0;
    if (retryCount >= _maxRetries) {
      return handler.reject(error);
    }

    error.requestOptions.extra['retry_count'] = retryCount + 1;
    if (_isRefreshing && _refreshTokenCompleter != null) {
      final isSuccess = await _refreshTokenCompleter!.future;
      if (isSuccess) {
        return _retryRequest(error.requestOptions, handler);
      } else {
        return handler.reject(error);
      }
    }

    _isRefreshing = true;
    _refreshTokenCompleter = Completer<bool>();

    try {
      final refreshed = await _performRefreshToken();

      _refreshTokenCompleter?.complete(refreshed);

      if (refreshed) {
        return _retryRequest(error.requestOptions, handler);
      } else {
        _handleSessionExpired();
        return handler.reject(error);
      }
    } catch (e) {
      log('Error handling unauthorized requests: $e');
      if (_refreshTokenCompleter?.isCompleted == false) {
        _refreshTokenCompleter?.complete(false);
      }
      return handler.next(error);
    } finally {
      _isRefreshing = false;
      _refreshTokenCompleter = null;
    }
  }

  Future<void> _retryRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final newAccessToken = await SecureStorageService.getAccessToken();

      final options = Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          'Authorization': 'Bearer $newAccessToken',
        },
      );
      final response = await dio.fetch(
        requestOptions.copyWith(headers: options.headers),
      );

      return handler.resolve(response);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: requestOptions,
          error: e,
          message: 'Retry failed',
        ),
      );
    }
  }

  Future<bool> _performRefreshToken() async {
    try {
      final refreshToken = await SecureStorageService.getRefreshToken();
      if (refreshToken == null) return false;

      final tokenDio = Dio(
        BaseOptions(
          baseUrl: ApiEndPoints.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await tokenDio.post(
        ApiEndPoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        var result = ApiResponse.fromJson(
          response.data,
          (json) => LoginSuccess.fromJson(json as Map<String, dynamic>),
        );

        SecureStorageService.clearAllTokens();
        final successData = result.data as LoginSuccess;

        SecureStorageService.saveTokens(
          accessToken: successData.tokenModel.accessToken,
          refreshToken: successData.tokenModel.refreshToken,
        );

        return true;
      } else if (response.statusCode == 401) {
        log('Refresh Token is expired or invalid. User must log in again.');
        return false;
      }

      return false;
    } catch (e) {
      log('Exception in refresh token: $e');
      return false;
    }
  }

  Future<void> _handleSessionExpired() async {
    await SecureStorageService.clearAllTokens();
    // AppSnackBar.session(AppLocalizations().sessionExpired);
    Future.delayed(
      AppConstantManager.sessionExpire,
      () => AppNavigator.pushNamedAndRemoveUntil(AppRoutePaths.login),
    );
  }
}
