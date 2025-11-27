import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mini_social_feed/core/constants/api_endpoints.dart';
import 'package:mini_social_feed/core/constants/app_constant_manager.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/services/secure_storage_service.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';

import '../../features/auth/data/models/login_data.dart';
import 'api_response.dart';

class DioClient {
  late final Dio dio;
  bool _isRefreshing = false;
  final List<RequestOptions> _pendingRequests = [];

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        followRedirects: true,
        maxRedirects: 5,
        validateStatus: (status) {
          return status != null && status < 400;
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final hasAccessToken = await SecureStorageService.hasAccessToken();
          if (hasAccessToken) {
            final accessToken = await SecureStorageService.getAccessToken();
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            return await _handleUnauthorizedError(error, handler);
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
    final requestOptions = error.requestOptions;

    if (_isRefreshing) {
      _pendingRequests.add(requestOptions);
      return;
    }

    _isRefreshing = true;

    try {
      final refreshed = await _refreshToken();

      if (refreshed) {
        final response = await _retryRequest(requestOptions);
        handler.resolve(response);

        await _processPendingRequests();
      } else {
        handler.next(error);
        _rejectPendingRequests(error);
      }
    } catch (e) {
      log('Error handling unauthorized request: $e');
      handler.next(error);
      _rejectPendingRequests(error);
    } finally {
      _isRefreshing = false;
      _pendingRequests.clear();
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await SecureStorageService.getRefreshToken();

      if (refreshToken == null) return false;

      final response = await Dio().post(
        ApiEndPoints.refreshToken,
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );
      var result = ApiResponse.fromJson(
        response.data,
        (json) => LoginData.fromJson(json as Map<String, dynamic>),
      );
      final successData = result as LoginSuccess;

      await SecureStorageService.clearAllTokens();

      await SecureStorageService.saveTokens(
        accessToken: successData.tokenModel.accessToken,
        refreshToken: successData.tokenModel.refreshToken,
      );
      return true;
    } catch (e) {
      log('Exception in refresh token: $e');
      _handleRefreshFailure();
      return false;
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final newAccessToken = await SecureStorageService.getAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newAccessToken',
      },
    );

    switch (requestOptions.method.toUpperCase()) {
      case 'GET':
        return await dio.get(
          requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
      case 'POST':
        return await dio.post(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
      case 'PUT':
        return await dio.put(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
      case 'DELETE':
        return await dio.delete(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
      case 'PATCH':
        return await dio.patch(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
      default:
        throw DioException(
          requestOptions: requestOptions,
          message: 'Unsupported HTTP method: ${requestOptions.method}',
        );
    }
  }

  Future<void> _processPendingRequests() async {
    final requests = List<RequestOptions>.from(_pendingRequests);
    _pendingRequests.clear();

    for (final request in requests) {
      try {
        await _retryRequest(request);
      } catch (e) {
        log('Error processing pending request: $e');
      }
    }
  }

  void _rejectPendingRequests(DioException originalError) {
    _pendingRequests.clear();
  }

  Future<void> _handleRefreshFailure() async {
    await SecureStorageService.clearAllTokens();
    AppSnackBar.session(AppLocalizations().sessionExpired);

    Future.delayed(
      AppConstantManager.kTransitionDuration,
      () => AppNavigator.pushNamedAndRemoveUntil(AppRoutePaths.login),
    );
  }
}
