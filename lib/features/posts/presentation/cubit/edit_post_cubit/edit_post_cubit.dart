import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';
import 'package:mini_social_feed/features/posts/data/requests/edit_post_request.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  EditPostCubit() : super(EditPostInitial());

  Future<void> editPost({required EditPostRequest request}) async {
    emit(EditPostLoading());
    var result = await getIt<PostRepository>().editPost(request: request);
    result.fold(
      (fail) {
        emit(EditPostFailure(fail.errMessage));
      },
      (success) {
        emit(EditPostSuccess(dataSuccess: success.data!));
      },
    );
  }
}
