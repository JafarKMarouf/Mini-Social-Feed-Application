import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';

part 'show_post_state.dart';

class ShowPostCubit extends Cubit<ShowPostState> {
  ShowPostCubit() : super(ShowPostInitial());

  Future<void> showPost({required String postId}) async {
    emit(ShowPostLoading());
    var result = await getIt<PostRepository>().showPost(postId: postId);
    result.fold(
      (fail) {
        emit(ShowPostFailure(errMsg: fail.errMessage));
      },
      (post) {
        emit(ShowPostSuccess(post: post));
      },
    );
  }
}
