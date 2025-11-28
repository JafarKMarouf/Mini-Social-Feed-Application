import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post_list_model.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';
import 'package:mini_social_feed/features/posts/data/requests/fetch_post_list_request.dart';

part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  PostListCubit() : super(PostListInitial());

  Future<void> fetchPostList({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(PostListLoading());
    } else {
      emit(PostListPaginationLoading());
    }
    var result = await getIt<PostRepository>().fetchListPost(
      request: FetchPostListRequest(perPage: pageNumber),
    );
    result.fold(
      (fail) {
        if (pageNumber == 0) {
          emit(PostListFailure(errMsg: fail.errMessage));
        } else {
          emit(PostListPaginationFailure(errMsg: fail.errMessage));
        }
      },
      (posts) {
        emit(PostListSuccess(posts: posts.data!));
      },
    );
  }
}
