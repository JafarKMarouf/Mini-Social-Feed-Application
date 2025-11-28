import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

enum AppUserInfoMode { compact, detailed }

class AppUserInfo extends StatelessWidget {
  final String userName;
  final double fontSize;
  final Color textColor;
  final String? imageProfile;

  final double imageSize;
  final double borderRadius;

  final IconData fallbackIcon;

  final String? emailAddress;
  final VoidCallback? onEditTap;

  final VoidCallback? onTap;

  final AppUserInfoMode mode;

  const AppUserInfo({
    super.key,
    required this.userName,
    this.fontSize = 14,
    this.textColor = Colors.white,
    this.imageSize = 50,
    this.borderRadius = 15,
    this.fallbackIcon = Icons.person,
    this.emailAddress,
    this.onEditTap,
    this.onTap,
    this.mode = AppUserInfoMode.compact,
    this.imageProfile,
  });

  @override
  Widget build(BuildContext context) {
    if (mode == AppUserInfoMode.compact) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppTextWidget(
              text: userName,
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.w600,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                width: imageSize,
                height: imageSize,
                color: Colors.white,
                child: Icon(
                  fallbackIcon,
                  size: imageSize * 0.65,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (onEditTap != null)
            InkWell(
              onTap: onEditTap,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(
                Icons.edit,
                size: 28,
                color: AppColorManager.white,
              ),
            ),

          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextWidget(
                      text: userName,
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (emailAddress != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: AppTextWidget(
                          text: emailAddress!,
                          fontSize: fontSize - 2,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Container(
                    width: imageSize,
                    height: imageSize,
                    color: Colors.white,
                    child: Icon(
                      fallbackIcon,
                      size: imageSize * 0.65,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
