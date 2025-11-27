import 'package:mini_social_feed/core/constants/api_endpoints.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/network/api_service.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/auth/data/models/login_data.dart';
import 'package:mini_social_feed/features/auth/data/models/register_data.dart';
import 'package:mini_social_feed/features/auth/data/models/user_model.dart';
import 'package:mini_social_feed/features/auth/data/requests/login_user_request.dart';
import 'package:mini_social_feed/features/auth/data/requests/register_user_request.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<RegisterData>> register({
    required RegisterUserRequest request,
  });

  Future<ApiResponse<LoginData>> login({required LoginUserRequest request});

  Future<ApiResponse> logout();

  Future<ApiResponse<UserModel>> getMyInfos();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<ApiResponse<RegisterData>> register({
    required RegisterUserRequest request,
  }) async {
    var data = await getIt<ApiService>().post(
      url: ApiEndPoints.register,
      body: request.toJson(),
    );

    return ApiResponse.fromJson(
      data.data,
      (json) => RegisterData.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<LoginData>> login({
    required LoginUserRequest request,
  }) async {
    var data = await getIt<ApiService>().post(
      url: ApiEndPoints.login,
      body: request.toJson(),
    );
    return ApiResponse.fromJson(
      data.data,
      (json) => LoginData.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse> logout() async {
    await getIt<ApiService>().post(url: ApiEndPoints.logout);
    return ApiResponse(status: true, message: 'Logout successful.');
  }

  @override
  Future<ApiResponse<UserModel>> getMyInfos() async {
    var data = await getIt<ApiService>().get(url: ApiEndPoints.me);
    return ApiResponse.fromJson(
      data.data,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
