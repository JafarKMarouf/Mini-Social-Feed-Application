import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/services/media_service.dart';
import 'package:mini_social_feed/core/utils/helper/app_alert_dialog.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';
import 'package:mini_social_feed/core/utils/helper/confim_exit_dialog.dart';
import 'package:mini_social_feed/core/utils/helper/validator.dart';
import 'package:mini_social_feed/core/utils/widgets/loading/loading_overlay.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/create_post_cubit/create_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/add_post_widgets/display_media_grid.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/add_post_widgets/media_tool_bar.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/add_post_widgets/post_app_bar.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/add_post_widgets/post_input_area.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final List<PlatformFile> _selectedFiles = [];

  Future<void> _pickMedia() async {
    final MediaService mediaService = MediaService();

    final files = await mediaService.pickMedia();
    if (files.isNotEmpty) {
      setState(() {
        _selectedFiles.addAll(files);
      });
    }
  }

  Future<void> _pickFile() async {
    final MediaService mediaService = MediaService();

    final files = await mediaService.pickDocuments();
    if (files.isNotEmpty) {
      setState(() {
        _selectedFiles.addAll(files);
      });
    }
  }

  Future<void> _takePhoto() async {
    final MediaService mediaService = MediaService();

    final file = await mediaService.takePhoto();
    if (file != null) {
      setState(() {
        _selectedFiles.add(file);
      });
    }
  }

  void _discardChanges() {
    if (_selectedFiles.isNotEmpty ||
        context.read<CreatePostCubit>().contentController.text.isNotEmpty ||
        context.read<CreatePostCubit>().titleController.text.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (contextBuilder) => appAlertDialog(
          context,
          title: AppLocalizations().discard,
          subTitle: AppLocalizations().discardConfirmation,
          onPressed: () {
            context.read<CreatePostCubit>().clearForm();
            setState(() {
              _selectedFiles.clear();
            });
            AppNavigator.pop(isRoot: true);
          },
          icon: Icons.clear,
        ),
      );
    }
  }

  void _dismissKeyboard(BuildContext context) =>
      FocusScope.of(context).unfocus();

  void _onPublishPressed(BuildContext context) {
    _dismissKeyboard(context);
    final cubit = context.read<CreatePostCubit>();

    if (Validator.validateForm(cubit.formKey)) {
      cubit.media.clear();

      if (_selectedFiles.isNotEmpty) {
        cubit.media.addAll(
          _selectedFiles
              .where((file) => file.path != null)
              .map((file) => File(file.path!)),
        );
      }

      cubit.createPost(request: cubit.createPostRequest());
    } else {
      setState(() {
        cubit.autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  void _handleStateChanges(BuildContext context, CreatePostState state) {
    if (state is CreatePostSuccess) {
      _selectedFiles.clear();
      AppSnackBar.info(context, AppLocalizations().successCreatePostMessage);
      AppNavigator.pushReplacementNamed(AppRoutePaths.home);
    }
    if (state is CreatePostFailure) {
      _selectedFiles.clear();
      AppSnackBar.error(context, state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: (context, state) => _handleStateChanges(context, state),
      child: WillPopScope(
        onWillPop: () async => await showConfirmExitDialog(
          context,
          confirmExist: () {
            context.read<CreatePostCubit>().clearForm();
            setState(() {
              _selectedFiles.clear();
            });
            AppNavigator.pop(isRoot: true);
            AppNavigator.pushReplacementNamed(AppRoutePaths.home);
          },
        ),
        child: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  PostAppBar(
                    discard: () => _discardChanges(),
                    title: AppLocalizations().createPost,
                    publishPost: () => _onPublishPressed(context),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20.0,
                      ),
                      child: BlocBuilder<CreatePostCubit, CreatePostState>(
                        builder: (context, state) {
                          final cubit = context.read<CreatePostCubit>();
                          return Form(
                            key: cubit.formKey,
                            autovalidateMode: cubit.autoValidateMode,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PostInputArea(cubit: cubit),
                                const SizedBox(height: 20),
                                if (_selectedFiles.isNotEmpty) ...[
                                  DisplayMediaGrid(
                                    selectedFiles: _selectedFiles,
                                    onRemove: (index) {
                                      setState(() {
                                        _selectedFiles.removeAt(index);
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                                MediaToolBar(
                                  pickMedia: _pickMedia,
                                  pickFile: _pickFile,
                                  takePhoto: _takePhoto,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<CreatePostCubit, CreatePostState>(
                builder: (context, state) {
                  return buildLoadingOverlay(state is CreatePostLoading);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
