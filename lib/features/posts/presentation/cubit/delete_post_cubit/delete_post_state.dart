part of 'delete_post_cubit.dart';

sealed class DeletePostState {}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostLoading extends DeletePostState {}

final class DeletePostSuccess extends DeletePostState {}

final class DeletePostFailure extends DeletePostState {
  final String message;

  DeletePostFailure(this.message);
}
