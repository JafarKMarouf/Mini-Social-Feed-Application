import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mini_social_feed/core/error/failure.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/data_source/post_remote_data_source.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post_list_model.dart';
import 'package:mini_social_feed/features/posts/data/requests/create_post_request.dart';
import 'package:mini_social_feed/features/posts/data/requests/edit_post_request.dart';
import 'package:mini_social_feed/features/posts/data/requests/fetch_post_list_request.dart';

abstract class PostRepository {
  Future<Either<Failure, ApiResponse<PostListModel>>> fetchListPost({
    FetchPostListRequest? request,
  });

  Future<Either<Failure, ApiResponse<Post>>> showPost({required String postId});

  Future<Either<Failure, ApiResponse>> createPost({
    required CreatePostRequest request,
  });

  Future<Either<Failure, ApiResponse<Post>>> editPost({
    required EditPostRequest request,
  });

  Future<Either<Failure, ApiResponse>> deletePost({required int postId});
}

class PostRepositoryImpl extends PostRepository {
  @override
  Future<Either<Failure, ApiResponse<PostListModel>>> fetchListPost({
    FetchPostListRequest? request,
  }) async {
    try {
      var result = await getIt<PostRemoteDataSource>().fetchListPost(
        request: request,
      );
      return Right(result);
    } catch (exception) {
      if (exception is DioException) {
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<Post>>> showPost({
    required String postId,
  }) async {
    try {
      var result = await getIt<PostRemoteDataSource>().showPost(postId: postId);
      return Right(result);
    } catch (exception) {
      if (exception is DioException) {
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> createPost({
    required CreatePostRequest request,
  }) async {
    try {
      var result = await getIt<PostRemoteDataSource>().createPost(
        request: request,
      );
      return Right(result);
    } catch (exception) {
      log('------exception in create post $exception-------------');
      if (exception is DioException) {
        log(
          '------exception in create post ${exception.response}-------------',
        );
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<Post>>> editPost({
    required EditPostRequest request,
  }) async {
    try {
      var result = await getIt<PostRemoteDataSource>().editPost(
        request: request,
      );
      return Right(result);
    } catch (exception) {
      if (exception is DioException) {
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> deletePost({
    required int postId,
  }) async {
    try {
      var result = await getIt<PostRemoteDataSource>().deletePost(
        postId: postId,
      );
      return Right(result);
    } catch (exception) {
      if (exception is DioException) {
        return Left(ServerFailure.fromDioError(exception));
      }
      return Left(ServerFailure(exception.toString()));
    }
  }
}
