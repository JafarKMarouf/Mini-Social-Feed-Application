part of 'create_post_cubit.dart';

sealed class CreatePostState {}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostLoading extends CreatePostState {}

final class CreatePostSuccess extends CreatePostState {}

final class CreatePostFailure extends CreatePostState {
  final String message;

  CreatePostFailure(this.message);
}
