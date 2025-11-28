part of 'post_list_cubit.dart';

sealed class PostListState {}

final class PostListInitial extends PostListState {}

final class PostListLoading extends PostListState {}

final class PostListPaginationLoading extends PostListState {}

final class PostListFailure extends PostListState {
  final String errMsg;

  PostListFailure({required this.errMsg});
}

final class PostListPaginationFailure extends PostListState {
  final String errMsg;

  PostListPaginationFailure({required this.errMsg});
}

final class PostListSuccess extends PostListState {
  final PostListModel posts;

  PostListSuccess({required this.posts});
}
