part of 'post_list_cubit.dart';

abstract class PostListState extends Equatable {
  const PostListState();

  @override
  List<Object> get props => [];
}

class PostListInitial extends PostListState {}

class PostListLoading extends PostListState {}

class PostListFailure extends PostListState {
  final String errMsg;

  const PostListFailure({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class PostListSuccess extends PostListState {
  final List<Post> posts;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const PostListSuccess({
    required this.posts,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  PostListSuccess copyWith({
    List<Post>? posts,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return PostListSuccess(
      posts: posts ?? this.posts,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, isLoadingMore, hasReachedMax];
}
