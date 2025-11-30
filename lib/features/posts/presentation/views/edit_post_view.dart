import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/services/media_service.dart';
import 'package:mini_social_feed/core/utils/helper/app_alert_dialog.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';
import 'package:mini_social_feed/core/utils/helper/confim_exit_dialog.dart';
import 'package:mini_social_feed/core/utils/helper/validator.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/loading/loading_overlay.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/edit_post_cubit/edit_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/show_post_cubit/show_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/add_post_widgets/display_media_grid.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/add_post_widgets/media_tool_bar.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/add_post_widgets/post_app_bar.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/edit_post_widgets/display_network_media_grid.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/edit_post_widgets/edit_post_input_area.dart';

class EditPostView extends StatefulWidget {
  const EditPostView({super.key});

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
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
        context.read<EditPostCubit>().contentController.text.isNotEmpty ||
        context.read<EditPostCubit>().titleController.text.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (contextBuilder) => appAlertDialog(
          context,
          title: 'Discard',
          subTitle: 'Are you sure to discard changes',
          onPressed: () {
            context.read<EditPostCubit>().clearForm();
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
    final cubit = context.read<EditPostCubit>();

    if (Validator.validateForm(cubit.formKey)) {
      cubit.newMediaFiles.clear();
      if (_selectedFiles.isNotEmpty) {
        cubit.newMediaFiles.addAll(
          _selectedFiles
              .where((file) => file.path != null)
              .map((file) => File(file.path!)),
        );
      }

      var request = cubit.createEditRequest();
      log('-----------request:${request.toJson()}');
      cubit.editPost(request: request);
    } else {
      setState(() {
        cubit.autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  void _handleStateChanges(BuildContext context, EditPostState state) {
    if (state is EditPostSuccess) {
      _selectedFiles.clear();
      AppSnackBar.info(context, 'Edit post success');
      AppNavigator.pushReplacementNamed(AppRoutePaths.home);
    }
    if (state is EditPostFailure) {
      _selectedFiles.clear();
      AppSnackBar.error(context, state.message);
      AppNavigator.pushReplacementNamed(AppRoutePaths.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EditPostCubit, EditPostState>(
          listener: (context, state) => _handleStateChanges(context, state),
        ),
        BlocListener<ShowPostCubit, ShowPostState>(
          listener: (context, state) {
            if (state is ShowPostSuccess) {
              context.read<EditPostCubit>().setInitialData(state.post.data!);
            }
            if (state is ShowPostFailure) {
              AppSnackBar.error(context, state.errMsg);
              AppNavigator.pop();
            }
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => await showConfirmExitDialog(
          context,
          confirmExist: () {
            context.read<EditPostCubit>().clearForm();
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
              BlocBuilder<ShowPostCubit, ShowPostState>(
                builder: (context, showState) {
                  if (showState is ShowPostLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColorManager.primary,
                      ),
                    );
                  }
                  return CustomScrollView(
                    slivers: [
                      PostAppBar(
                        discard: () => _discardChanges(),
                        title: 'Edit',
                        publishPost: () => _onPublishPressed(context),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 20.0,
                          ),
                          child: BlocBuilder<EditPostCubit, EditPostState>(
                            builder: (context, state) {
                              final cubit = context.read<EditPostCubit>();
                              return Form(
                                key: cubit.formKey,
                                autovalidateMode: cubit.autoValidateMode,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EditPostInputArea(cubit: cubit),
                                    const SizedBox(height: 20),

                                    if (cubit.existingMedia.isNotEmpty) ...[
                                      const Text(
                                        'Existing Media',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColorManager.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      DisplayNetworkMediaGrid(
                                        mediaList: cubit.existingMedia,
                                        onRemove: (media) {
                                          context
                                              .read<EditPostCubit>()
                                              .removeExistingMedia(media);
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                    ],

                                    if (_selectedFiles.isNotEmpty) ...[
                                      const Text(
                                        'New Media',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColorManager.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
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
                  );
                },
              ),

              BlocBuilder<EditPostCubit, EditPostState>(
                builder: (context, state) {
                  return buildLoadingOverlay(state is EditPostLoading);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
