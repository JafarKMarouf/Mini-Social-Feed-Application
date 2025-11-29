part of 'edit_post_cubit.dart';

sealed class EditPostState {}

final class EditPostInitial extends EditPostState {}

final class EditPostLoading extends EditPostState {}

final class EditPostSuccess extends EditPostState {
  final Post dataSuccess;

  EditPostSuccess({required this.dataSuccess});
}

final class EditPostFailure extends EditPostState {
  final String message;

  EditPostFailure(this.message);
}
