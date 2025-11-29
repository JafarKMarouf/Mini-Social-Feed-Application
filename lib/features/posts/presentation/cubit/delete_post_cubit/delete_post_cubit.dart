import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());

  Future<void> deletePost({required int postId}) async {
    emit(DeletePostLoading());
    var result = await getIt<PostRepository>().deletePost(postId: postId);
    result.fold(
      (fail) {
        emit(DeletePostFailure(fail.errMessage));
      },
      (success) {
        emit(DeletePostSuccess());
      },
    );
  }
}
