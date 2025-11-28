part of 'show_post_cubit.dart';

sealed class ShowPostState {}

final class ShowPostInitial extends ShowPostState {}

final class ShowPostLoading extends ShowPostState {}

final class ShowPostFailure extends ShowPostState {
  final String errMsg;

  ShowPostFailure({required this.errMsg});
}

final class ShowPostSuccess extends ShowPostState {
  final ApiResponse<Post> post;

  ShowPostSuccess({required this.post});
}
