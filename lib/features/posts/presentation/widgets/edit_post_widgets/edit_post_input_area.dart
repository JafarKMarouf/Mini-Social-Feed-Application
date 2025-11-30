import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/features/posts/presentation/cubit/edit_post_cubit/edit_post_cubit.dart';

import '../../../../../core/utils/resources/app_text_style.dart';

class EditPostInputArea extends StatelessWidget {
  final EditPostCubit cubit;

  const EditPostInputArea({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: CachedNetworkImageProvider(
            'https://i.pravatar.cc/150?img=5',
          ),
          backgroundColor: AppColorManager.gray,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: cubit.titleController,
                style: AppTextStyle.styleUrbanistBold17(context).copyWith(
                  color: AppColorManager.white,
                  fontSize: FontSizeManager.fs18,
                ),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: AppTextStyle.styleUrbanistBold17(context).copyWith(
                    color: AppColorManager.gray,
                    fontSize: FontSizeManager.fs18,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 8),
                  isDense: true,
                ),
                cursorColor: AppColorManager.primary,
                maxLines: 2,
                maxLength: 60,
                textCapitalization: TextCapitalization.sentences,
              ),
              TextFormField(
                controller: cubit.contentController,
                maxLines: null,
                style: AppTextStyle.styleUrbanistSemiBold15(context).copyWith(
                  color: AppColorManager.white,
                  fontSize: FontSizeManager.fs17,
                ),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  hintStyle: AppTextStyle.styleUrbanistSemiBold15(context)
                      .copyWith(
                        color: AppColorManager.gray,
                        fontSize: FontSizeManager.fs17,
                      ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                cursorColor: AppColorManager.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
