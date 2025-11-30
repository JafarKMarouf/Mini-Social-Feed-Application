import 'dart:convert';

import 'package:mini_social_feed/core/constants/api_endpoints.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/network/api_service.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post_list_model.dart';
import 'package:mini_social_feed/features/posts/data/requests/create_post_request.dart';
import 'package:mini_social_feed/features/posts/data/requests/edit_post_request.dart';
import 'package:mini_social_feed/features/posts/data/requests/fetch_post_list_request.dart';

abstract class PostRemoteDataSource {
  Future<ApiResponse<PostListModel>> fetchListPost({
    FetchPostListRequest? request,
  });

  Future<ApiResponse<Post>> showPost({required String postId});

  Future<ApiResponse> createPost({required CreatePostRequest request});

  Future<ApiResponse<Post>> editPost({required EditPostRequest request});

  Future<ApiResponse> deletePost({required int postId});
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  @override
  Future<ApiResponse<PostListModel>> fetchListPost({
    FetchPostListRequest? request,
  }) async {
    var data = await getIt<ApiService>().get(
      url:
          '${ApiEndPoints.posts}?page=${request?.nextPage}&current_page=${request?.currentPage}&per_page=${request?.perPage}&search=${request?.search}&media_type=${request?.mediaType}',
    );

    return ApiResponse.fromJson(
      data.data,
      (json) => PostListModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<Post>> showPost({required String postId}) async {
    var data = await getIt<ApiService>().get(
      url: '${ApiEndPoints.posts}/$postId',
    );

    return ApiResponse.fromJson(
      data.data,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<Post>> createPost({
    required CreatePostRequest request,
  }) async {
    try {
      final formData = await CreatePostRequest.createFormData(request);

      var response = await getIt<ApiService>().post(
        url: ApiEndPoints.posts,
        body: formData,
        requiresAuth: true,
      );

      var responseData = response.data;

      if (responseData is String) {
        try {
          responseData = jsonDecode(responseData);
        } catch (e) {
          throw const FormatException('Server returned invalid JSON format');
        }
      }

      if (responseData is! Map<String, dynamic>) {
        throw FormatException(
          'Expected Map<String, dynamic> but got ${responseData.runtimeType}',
        );
      }

      return ApiResponse.fromJson(
        responseData,
        (json) => Post.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<Post>> editPost({required EditPostRequest request}) async {
    final formData = await EditPostRequest.createFormData(request);
    var data = await getIt<ApiService>().put(
      url: '${ApiEndPoints.posts}/${request.id}',
      body: formData,
      requiresAuth: true,
    );
    return ApiResponse.fromJson(
      data.data,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse> deletePost({required int postId}) async {
    var response = await getIt<ApiService>().delete(
      url: '${ApiEndPoints.posts}/$postId',
      requiresAuth: true,
    );
    return ApiResponse(
      status: response.data['status'],
      message: response.data['message'],
    );
  }
}
