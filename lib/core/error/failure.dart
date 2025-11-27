import 'package:dio/dio.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';

abstract class Failure {
  final String errMessage;
  final int? statusCode;

  const Failure(this.errMessage, {this.statusCode});
}

class ServerFailure extends Failure {
  static final locale = AppLocalizations();

  ServerFailure(super.errMessage, {super.statusCode});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(locale.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return ServerFailure(locale.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(locale.receiveTimeout);
      case DioExceptionType.badCertificate:
        return ServerFailure(locale.badCertificate);
      case DioExceptionType.badResponse:
        return ServerFailure._fromResponse(dioError.response);
      case DioExceptionType.cancel:
        return ServerFailure(locale.requestCancelled);
      case DioExceptionType.connectionError:
        return ServerFailure(locale.noInternetConnection);
      case DioExceptionType.unknown:
        return ServerFailure(locale.unknownError);
    }
  }

  factory ServerFailure._fromResponse(Response? response) {
    final statusCode = response?.statusCode;
    switch (statusCode) {
      case 400:
        return ServerFailure(locale.badRequest, statusCode: 400);
      case 401:
        return ServerFailure(locale.unauthorized, statusCode: 401);
      case 403:
        return ServerFailure(locale.forbidden, statusCode: 403);
      case 404:
        return ServerFailure(locale.notFound, statusCode: 404);
      case 408:
        return ServerFailure(locale.requestTimeout, statusCode: 408);
      case 409:
        return ServerFailure(locale.conflict, statusCode: 409);
      case 422:
        return ServerFailure(locale.unprocessableEntity, statusCode: 422);
      case 429:
        return ServerFailure(locale.tooManyRequests, statusCode: 429);
      case 500:
        return ServerFailure(locale.internalServerError);
      case 502:
        return ServerFailure(locale.badGateway);
      case 503:
        return ServerFailure(locale.serviceUnavailable);
      case 504:
        return ServerFailure(locale.gatewayTimeout);
      default:
        if (statusCode != null && statusCode >= 500) {
          return ServerFailure(
            locale.serverErrorWithCode(statusCode),
            statusCode: statusCode,
          );
        } else if (statusCode != null && statusCode >= 400) {
          return ServerFailure(
            locale.requestErrorWithCode(statusCode),
            statusCode: statusCode,
          );
        } else {
          return ServerFailure(
            locale.unknownErrorCode(statusCode ?? 'no code'),
          );
        }
    }
  }
}

class ValidationFailure extends Failure {
  final Map<String, String> errors;

  ValidationFailure(super.errMessage, {required this.errors});

  factory ValidationFailure.fromDioError(DioException error) {
    if (error.response?.data is Map<String, dynamic> &&
        error.response?.data['errors'] is Map) {
      final Map<String, dynamic> errorMap = error.response!.data['errors'];
      final Map<String, String> validationErrors = {};

      errorMap.forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          validationErrors[key] = value.first.toString();
        }
      });

      return ValidationFailure(error.message!, errors: validationErrors);
    }
    return ValidationFailure(
      error.message!,
      errors: {
        'general':
            error.response?.data['message'] ?? 'Validation error occurred',
      },
    );
  }
}
