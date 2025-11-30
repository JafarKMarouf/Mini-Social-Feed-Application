import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

Widget appAlertDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  required void Function()? onPressed,
  required IconData icon,
  Color? color,
}) {
  return AlertDialog(
    backgroundColor: AppColorManager.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppTextWidget(
          text: title,
          fontSize: FontSizeManager.fs18,
          fontWeight: FontWeight.w800,
          color: AppColorManager.dark,
        ),
        const SizedBox(width: 12),
        Icon(icon, color: color ?? AppColorManager.primary, size: 28),
      ],
    ),
    content: AppTextWidget(
      text: subTitle,
      fontSize: FontSizeManager.fs14,
      color: AppColorManager.dark,
      fontWeight: FontWeight.w600,
    ),
    actions: [
      TextButton(
        onPressed: () => AppNavigator.pop(isRoot: false),
        child: AppTextWidget(
          text: AppLocalizations().cancel,
          fontSize: FontSizeManager.fs15,
          fontWeight: FontWeight.w700,
          color: AppColorManager.dark,
        ),
      ),
      ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: AppTextWidget(
          text: title,
          fontSize: FontSizeManager.fs15,
          fontWeight: FontWeight.w700,
          color: AppColorManager.white,
        ),
      ),
    ],
  );
}
