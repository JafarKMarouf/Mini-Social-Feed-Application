import 'package:mini_social_feed/core/constants/api_endpoints.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/network/api_service.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post_list_model.dart';
import 'package:mini_social_feed/features/posts/data/requests/fetch_post_list_request.dart';

abstract class PostRemoteDataSource {
  Future<ApiResponse<PostListModel>> fetchListPost({
    FetchPostListRequest? request,
  });

  Future<ApiResponse<Post>> showPost({required String postId});
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  @override
  Future<ApiResponse<PostListModel>> fetchListPost({
    FetchPostListRequest? request,
  }) async {
    var data = await getIt<ApiService>().get(
      url:
          '${ApiEndPoints.posts}?per_page=${request?.perPage}&search=${request?.search}&media_type=${request?.mediaType}',
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
}
