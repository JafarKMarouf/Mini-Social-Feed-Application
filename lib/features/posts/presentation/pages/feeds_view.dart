import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/core/utils/widgets/loading/loading_overlay.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/delete_post_cubit/delete_post_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/post_list_cubit/post_list_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/feeds_header.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/post_widget.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/stories_section.dart';

class FeedsView extends StatefulWidget {
  const FeedsView({super.key});

  @override
  State<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<PostListCubit>().fetchPostList();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostListCubit>().loadMorePosts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.7);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: AppColorManager.primary,
        onRefresh: () async {
          await context.read<PostListCubit>().fetchPostList();
        },
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: FeedsHeader()),
                const SliverToBoxAdapter(child: StoriesSection()),

                BlocBuilder<PostListCubit, PostListState>(
                  builder: (context, state) {
                    if (state is PostListLoading) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(50.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColorManager.primary,
                            ),
                          ),
                        ),
                      );
                    } else if (state is PostListFailure) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: AppTextWidget(
                            text: 'Error: ${state.errMsg}',
                            style: AppTextStyle.styleUrbanistBold22(
                              context,
                            ).copyWith(color: AppColorManager.white),
                          ),
                        ),
                      );
                    } else if (state is PostListSuccess) {
                      return SliverList.builder(
                        itemCount: state.isLoadingMore
                            ? state.posts.length + 1
                            : state.posts.length,

                        itemBuilder: (context, index) {
                          if (index >= state.posts.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: AppColorManager.primary,
                                ),
                              ),
                            );
                          }
                          return PostWidget(post: state.posts[index]);
                        },
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
            BlocConsumer<DeletePostCubit, DeletePostState>(
              listener: (context, state) {
                if (state is DeletePostFailure) {
                  AppSnackBar.error(context, state.message);
                }
                if (state is DeletePostSuccess) {
                  context.read<PostListCubit>().fetchPostList();
                }
              },
              builder: (context, state) {
                return buildLoadingOverlay(state is DeletePostLoading);
              },
            ),
          ],
        ),
      ),
    );
  }
}
