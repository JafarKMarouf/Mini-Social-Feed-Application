import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';
import 'package:mini_social_feed/features/posts/data/requests/fetch_post_list_request.dart';

part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  PostListCubit() : super(PostListInitial());

  int _currentPage = 0;
  int _nextPage = 0;
  int _pageSize = 10;
  String _currentSearch = '';
  String? _currentMediaType;

  Future<void> fetchPostList({String? search, String? mediaType}) async {
    _currentPage = 0;
    _nextPage = 0;
    _pageSize = 10;
    if (search != null) {
      _currentSearch = search;
    }
    if (mediaType != null) {
      _currentMediaType = mediaType;
    }

    emit(PostListLoading());

    await _fetchData();
  }

  Future<void> loadMorePosts() async {
    final currentState = state;
    if (currentState is PostListSuccess) {
      if (currentState.isLoadingMore || currentState.hasReachedMax) return;

      emit(currentState.copyWith(isLoadingMore: true));

      _currentPage++;
      _nextPage++;
      await _fetchData(isPagination: true);
    }
  }

  Future<void> _fetchData({bool isPagination = true}) async {
    var result = await getIt<PostRepository>().fetchListPost(
      request: FetchPostListRequest(
        nextPage: _nextPage,
        currentPage: _currentPage,
        search: _currentSearch,
        mediaType: _currentMediaType,
      ),
    );

    result.fold(
      (fail) {
        emit(PostListFailure(errMsg: fail.errMessage));
      },
      (postListModel) {
        final newPosts = postListModel.data?.posts ?? [];
        final pagination = postListModel.data?.pagination;

        bool hasReachedMax = false;
        if (pagination != null) {
          hasReachedMax = _currentPage >= (pagination.lastPage ?? 1);
        } else {
          if (newPosts.length < _pageSize) hasReachedMax = true;
        }

        if (isPagination && state is PostListSuccess) {
          final currentPosts = (state as PostListSuccess).posts;
          emit(
            PostListSuccess(
              posts: [...currentPosts, ...newPosts],
              isLoadingMore: false,
              hasReachedMax: hasReachedMax,
            ),
          );
        } else {
          emit(
            PostListSuccess(
              posts: newPosts,
              isLoadingMore: false,
              hasReachedMax: hasReachedMax,
            ),
          );
        }
      },
    );
  }
}
