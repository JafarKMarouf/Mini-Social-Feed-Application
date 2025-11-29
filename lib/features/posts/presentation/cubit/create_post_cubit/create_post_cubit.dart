import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/posts/data/repositories/post_repository.dart';
import 'package:mini_social_feed/features/posts/data/requests/create_post_request.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInitial()) {
    _initializeControllers();
  }

  // Text editing controllers
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late final List<File> media;
  late final GlobalKey<FormState> formKey;
  late AutovalidateMode autoValidateMode;

  void _initializeControllers() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    media = [];
    autoValidateMode = AutovalidateMode.disabled;
    formKey = GlobalKey<FormState>();
  }

  CreatePostRequest createPostRequest() {
    return CreatePostRequest(
      title: titleController.text,
      content: contentController.text,
      media: media,
    );
  }

  Future<void> createPost({required CreatePostRequest request}) async {
    emit(CreatePostLoading());
    var result = await getIt<PostRepository>().createPost(request: request);
    result.fold(
      (fail) {
        clearForm();
        emit(CreatePostFailure(fail.errMessage));
      },
      (success) {
        clearForm();
        emit(CreatePostSuccess());
        // emit(CreatePostSuccess(dataSuccess: success.data!));
      },
    );
  }

  void clearForm() {
    titleController.clear();
    contentController.clear();
    media.clear();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contentController.dispose();
    return super.close();
  }
}
