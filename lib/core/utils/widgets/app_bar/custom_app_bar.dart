import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  final Color? solidColor;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final TextAlign? titleAlign;

  final Color? backButtonColor;
  final double? backButtonSize;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.solidColor,
    this.titleColor,
    this.titleSize,
    this.titleWeight,
    this.titleAlign,
    this.backButtonColor,
    this.backButtonSize,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: solidColor ?? AppColorManager.primary,
      elevation: 0,
      centerTitle: true,
      title: AppTextWidget(
        text: title,
        style: TextStyle(
          fontFamily: FontFamilyManager.urbanist,
          color: titleColor ?? AppColorManager.white,
          fontSize: titleSize ?? FontSizeManager.fs18,
          fontWeight: titleWeight ?? FontWeight.w200,
        ),
        textDirection: TextDirection.rtl,
        textAlign: titleAlign ?? TextAlign.center,
      ),
      actions: [
        if (showBackButton)
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: backButtonColor ?? Colors.white,
                size: backButtonSize ?? 24,
              ),
              onPressed: () => AppNavigator.pop(),
            ),
          ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
