import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/core/utils/widgets/form_field/app_form_field.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/post_list_cubit/post_list_cubit.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/feeds_widget/post_widget.dart';
import 'package:mini_social_feed/features/posts/presentation/widgets/search_widgets/build_filter_chips.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;
  String? _selectedMediaType;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
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
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 2), () {
      _triggerSearch();
    });
  }

  void _onFilterSelected(String? type) {
    setState(() {
      if (_selectedMediaType == type) {
        _selectedMediaType = null;
      } else {
        _selectedMediaType = type;
      }
    });
    _triggerSearch();
  }

  void _triggerSearch() {
    if (_searchController.text.isEmpty && _selectedMediaType == null) {
      return;
    }

    context.read<PostListCubit>().fetchPostList(
      search: _searchController.text,
      mediaType: _selectedMediaType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColorManager.background,
            title: AppTextWidget(
              text: AppLocalizations().explore,
              style: AppTextStyle.styleUrbanistBold22(
                context,
              ).copyWith(color: AppColorManager.white),
            ),
            centerTitle: true,

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(130),
              child: Container(
                color: AppColorManager.background,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    AppTextFormField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      fillColor: AppColorManager.dark.withOpacity(0.5),
                      borderRadius: 16,
                      borderColor: Colors.white38,
                      hintText: '${AppLocalizations().searchPosts}...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      textStyle: AppTextStyle.styleUrbanistBold17(
                        context,
                      ).copyWith(color: AppColorManager.white),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColorManager.white,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged('');
                              },
                            )
                          : null,
                    ),
                    const SizedBox(height: 16),
                    BuildFilterChips(
                      onFilterSelected: _onFilterSelected,
                      selectedMediaType: _selectedMediaType,
                    ),
                  ],
                ),
              ),
            ),
          ),

          BlocBuilder<PostListCubit, PostListState>(
            builder: (context, state) {
              if (state is PostListLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColorManager.primary,
                    ),
                  ),
                );
              }

              if (state is PostListFailure) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.errMsg,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }

              if (state is PostListSuccess) {
                if (state.posts.isEmpty) {
                  return _buildEmptyState();
                }

                return SliverList.builder(
                  itemCount: state.isLoadingMore
                      ? state.posts.length + 1
                      : state.posts.length,
                  itemBuilder: (context, index) {
                    if (index >= state.posts.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    return PostWidget(post: state.posts[index]);
                  },
                );
              }
              return _buildInitialState();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.white.withOpacity(0.1)),
            const SizedBox(height: 10),
            Text(
              'Type to search',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.white.withOpacity(0.1),
            ),
            const SizedBox(height: 10),
            Text(
              'No results found',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
