import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

abstract class AppSnackBar {
  static SnackBar _buildSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData iconData,
    required Color iconColor,
    required Duration duration,
    String? title,
  }) {
    final String finalTitle = title ?? '';
    final String finalMessage = finalTitle.isNotEmpty
        ? '$finalTitle\n$message'
        : message;

    return SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: AppTextWidget(
              text: finalMessage,
              style: AppTextStyle.styleUrbanistBold17(
                context,
              ).copyWith(color: AppColorManager.white),
              maxLines: 3,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  static void success(context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar(
        context: context,
        message: message,
        title: title,
        backgroundColor: AppColorManager.primary,
        iconData: Icons.check_circle_outline,
        iconColor: Colors.white,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void warning(context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar(
        context: context,
        message: message,
        title: title,
        backgroundColor: AppColorManager.gray,
        iconData: Icons.warning_amber_rounded,
        iconColor: Colors.yellow,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static void error(context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar(
        context: context,
        message: message,
        title: title,
        backgroundColor: AppColorManager.error,
        iconData: Icons.error_outline_rounded,
        iconColor: Colors.white,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void info(context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar(
        context: context,
        message: message,
        title: title,
        backgroundColor: AppColorManager.darkGray,
        iconData: Icons.info_outline,
        iconColor: Colors.cyan,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static void session(String message, {String? title}) {
    Get.snackbar(
      title ?? '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColorManager.primary,
      snackStyle: SnackStyle.GROUNDED,
    );
  }
}
