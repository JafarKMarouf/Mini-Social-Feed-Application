import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mini_social_feed/core/error/failure.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/services/secure_storage_service.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:mini_social_feed/features/auth/data/models/login_data.dart';
import 'package:mini_social_feed/features/auth/data/models/register_data.dart';
import 'package:mini_social_feed/features/auth/data/models/user_model.dart';
import 'package:mini_social_feed/features/auth/data/requests/login_user_request.dart';
import 'package:mini_social_feed/features/auth/data/requests/register_user_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, ApiResponse<RegisterData>>> register({
    required RegisterUserRequest request,
  });

  Future<Either<Failure, ApiResponse<LoginData>>> login({
    required LoginUserRequest request,
  });

  Future<Either<Failure, ApiResponse>> logout();

  Future<Either<Failure, ApiResponse<UserModel>>> getMyInfos();
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, ApiResponse<RegisterData>>> register({
    required RegisterUserRequest request,
  }) async {
    try {
      var result = await getIt<AuthRemoteDataSource>().register(
        request: request,
      );
      final registerData = result.data as RegisterData;
      if (registerData is RegisterSuccess) {
        SecureStorageService.clearAllTokens();
        SecureStorageService.saveTokens(
          accessToken: registerData.tokenModel.accessToken,
          refreshToken: registerData.tokenModel.refreshToken,
        );
        return Right(result);
      } else if (registerData is RegisterFailure) {
        return Left(
          ValidationFailure(registerData.message, errors: registerData.errors),
        );
      }
      return Left(ServerFailure(AppLocalizations().dataProcessingError));
    } catch (exception) {
      if (exception is TypeError) {
        return Left(ServerFailure(AppLocalizations().dataProcessingError));
      }
      if (exception is DioException) {
        if (exception.response?.statusCode == 422 ||
            exception.response?.statusCode == 400) {
          return Left(ValidationFailure.fromDioError(exception));
        }
        return Left(ServerFailure.fromDioError(exception));
      }

      return Left(ServerFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<LoginData>>> login({
    required LoginUserRequest request,
  }) async {
    try {
      var result = await getIt<AuthRemoteDataSource>().login(request: request);
      SecureStorageService.clearAllTokens();
      final loginData = result.data as LoginData;
      if (result.data is LoginSuccess) {
        final successData = loginData as LoginSuccess;

        SecureStorageService.saveTokens(
          accessToken: successData.tokenModel.accessToken,
          refreshToken: successData.tokenModel.refreshToken,
        );
      }
      return Right(result);
    } catch (exception) {
      if (exception is DioException) {
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> logout() async {
    try {
      var result = await getIt<AuthRemoteDataSource>().logout();
      await SecureStorageService.clearAllTokens();
      return Right(result);
    } catch (exception) {
      if (exception is DioException) {
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<UserModel>>> getMyInfos() async {
    try {
      var result = await getIt<AuthRemoteDataSource>().getMyInfos();

      return Right(result);
    } catch (exception) {
      if (exception is DioException) {
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }
}
