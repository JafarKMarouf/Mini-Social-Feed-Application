import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

Future<bool> showConfirmExitDialog(
  BuildContext context, {
  void Function()? confirmExist,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTextWidget(
                text: 'هل تريد الخروج؟',
                fontSize: FontSizeManager.fs17,
                fontWeight: FontWeight.bold,
                color: AppColorManager.dark,
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.exit_to_app,
                color: AppColorManager.primary,
                size: 28,
              ),
            ],
          ),
          content: AppTextWidget(
            text: 'لديك تغييرات غير محفوظة. هل تريد الخروج بدون حفظ؟',
            fontSize: FontSizeManager.fs15,
            color: AppColorManager.dark,
            maxLines: 2,
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () => AppNavigator.pop(isRoot: false),
              child: AppTextWidget(
                text: 'إلغاء',
                fontSize: FontSizeManager.fs15,
                fontWeight: FontWeight.w500,
                color: AppColorManager.dark,
              ),
            ),
            ElevatedButton(
              onPressed: confirmExist ?? () => AppNavigator.pop(isRoot: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColorManager.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: AppTextWidget(
                text: 'خروج',
                fontSize: FontSizeManager.fs15,
                color: AppColorManager.white,
              ),
            ),
          ],
        ),
      ) ??
      false;
}
