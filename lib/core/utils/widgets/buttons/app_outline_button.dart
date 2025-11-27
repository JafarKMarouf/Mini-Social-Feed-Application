import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

class AppOutlineButton extends StatelessWidget {
  final Color borderColor;
  final String text;
  final void Function()? onPressed;
  final double? height;
  final double borderWidth;
  final Color? textColor;
  final bool loading;
  final double? fontSize;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const AppOutlineButton({
    super.key,
    required this.borderColor,
    required this.text,
    required this.onPressed,
    this.height,
    this.borderWidth = 1.5,
    this.textColor,
    this.fontSize,
    this.textStyle,
    this.loading = false,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final tc = textColor ?? borderColor;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: borderWidth),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(15),
        ),
        fixedSize: height != null ? Size.fromHeight(height!) : null,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      ),

      onPressed: onPressed,
      child: Center(
        child: AppTextWidget(
          text: loading ? '...' : text,
          style:
              textStyle ??
              TextStyle(
                fontWeight: FontWeight.w800,
                color: tc,
                fontSize: fontSize ?? FontSizeManager.fs17,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
