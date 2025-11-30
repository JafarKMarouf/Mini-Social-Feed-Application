import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/media.dart';
import 'package:mini_social_feed/features/posts/data/models/post_list_model/post.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';
import 'package:mini_social_feed/features/posts/data/requests/edit_post_request.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  EditPostCubit() : super(EditPostInitial()) {
    _initializeControllers();
  }

  // Text editing controllers
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  // late final List<File> media;
  late final GlobalKey<FormState> formKey;
  late AutovalidateMode autoValidateMode;

  // Data holders
  String? postId;
  List<File> newMediaFiles = [];
  List<Media> existingMedia = [];
  List<int> deletedMediaIds = [];

  void _initializeControllers() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    newMediaFiles = [];
    existingMedia = [];
    autoValidateMode = AutovalidateMode.disabled;
    formKey = GlobalKey<FormState>();
  }

  void setInitialData(Post post) {
    postId = post.id.toString();
    titleController.text = post.title ?? '';
    contentController.text = post.content ?? '';
    // existingMedia = post.media ?? [];
    existingMedia = List.from(post.media ?? []);
    deletedMediaIds = [];
    // Emit initial state to refresh UI if needed
    emit(EditPostInitial());
  }

  void removeExistingMedia(Media media) {
    if (media.id != null) {
      deletedMediaIds.add(media.id!);
      existingMedia.remove(media);
      // Emit a dummy state to force the UI to rebuild (or copyWith if you have it)
      // Since your state is simple, emitting Initial again works to trigger BlocBuilder
      emit(EditPostInitial());
    }
  }

  EditPostRequest createEditRequest() {
    return EditPostRequest(
      id: postId!,
      title: titleController.text,
      content: contentController.text,
      media: newMediaFiles,
      removedMediaIds: deletedMediaIds,
      // Only send NEW files to the backend
      // Note: Depending on your backend, you might need to send a list of
      // existing media IDs to keep, or the backend handles append/replace logic.
    );
  }

  Future<void> editPost({required EditPostRequest request}) async {
    if (postId == null) {
      emit(EditPostFailure('Post ID is missing'));
      return;
    }

    emit(EditPostLoading());
    var result = await getIt<PostRepository>().editPost(request: request);
    result.fold(
      (fail) {
        emit(EditPostFailure(fail.errMessage));
      },
      (success) {
        clearForm();
        log('------------success message:${success.message}');
        log('------------success data:${success.data!.toJson()}');
        emit(EditPostSuccess(dataSuccess: success.data!));
      },
    );
  }

  void clearForm() {
    titleController.clear();
    contentController.clear();
    newMediaFiles.clear();
    existingMedia.clear();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contentController.dispose();
    return super.close();
  }
}
