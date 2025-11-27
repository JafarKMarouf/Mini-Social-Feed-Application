import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

class AppPrimaryButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;

  final double? height;

  final Color textColor;
  final TextStyle? textStyle;

  const AppPrimaryButton({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final double resolvedHeight = height ?? AppHeightManager.h5point2;

    return SizedBox(
      width: width,
      height: resolvedHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(15),
          ),
          elevation: 0,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : AppTextWidget(
                  text: text,
                  style:
                      textStyle ??
                      TextStyle(
                        fontWeight: fontWeight ?? FontWeight.w800,
                        color: textColor,
                        fontSize: fontSize ?? FontSizeManager.fs17,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
    );
  }
}
