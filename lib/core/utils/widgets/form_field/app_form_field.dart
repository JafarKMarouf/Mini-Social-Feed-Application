import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';

class AppTextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? enabled;
  final String? Function(String?)? validator;

  // onFieldSubmitted
  final void Function(String)? onFieldSubmitted;

  // editing complete
  final VoidCallback? editingComplete;

  // onChanged
  final void Function(String)? onChanged;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? labelText;
  final String? initialValue;
  final TextAlignVertical? textAlignVertical;
  final String? errorText;
  final Color? labelColor;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool? expand;
  final bool? autoFocus;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? textStyle;
  final bool enableBorder;
  final Color? borderColor;

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? prefixIconConstraints;

  const AppTextFormField({
    super.key,
    this.borderRadius,
    this.prefixIconConstraints,
    this.minLines,
    this.filled,
    this.errorText,
    this.enabled,
    this.suffixIcon,
    this.fillColor,
    this.expand,
    this.contentPadding,
    this.controller,
    this.obscureText,
    this.autoFocus,
    this.validator,
    this.hintStyle,
    this.editingComplete,
    this.onChanged,
    this.textInputType,
    this.textInputAction,
    this.textAlignVertical,
    this.focusNode,
    this.labelText,
    this.labelColor,
    this.onFieldSubmitted,
    this.initialValue,
    this.maxLines,
    this.prefixIcon,
    this.prefix,
    this.hintText,
    this.borderColor,
    this.enableBorder = true,
    this.width,
    this.height,
    this.margin,
    this.floatingLabelBehavior,
    this.textStyle,
  });

  InputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius ?? AppRadiusManager.r15),
      ),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        key: Key(initialValue ?? ''),
        textAlignVertical: textAlignVertical,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: AppColorManager.darkGray,
        validator: validator,
        controller: controller,
        focusNode: focusNode,

        obscureText: obscureText ?? false,
        onChanged: onChanged,
        autofocus: autoFocus ?? false,
        onEditingComplete: editingComplete,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: (obscureText ?? false) ? 1 : maxLines,
        initialValue: controller == null ? initialValue : null,
        enabled: enabled,
        expands: expand ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          filled: filled ?? true,
          fillColor: fillColor ?? AppColorManager.inputFillColor,
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefix: prefix,
          errorText: errorText,
          prefixIconConstraints: prefixIconConstraints,
          errorStyle: AppTextStyle.styleUrbanistMedium16(
            context,
          ).copyWith(color: AppColorManager.error),
          errorMaxLines: 2,
          hintStyle:
              hintStyle ??
              AppTextStyle.styleUrbanistSemiBold15(
                context,
              ).copyWith(color: AppColorManager.darkGray),
          labelText: (labelText != null && labelText!.isNotEmpty)
              ? labelText
              : null,
          labelStyle: AppTextStyle.styleUrbanistSemiBold15(
            context,
          ).copyWith(color: AppColorManager.darkGray),

          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.never,

          enabledBorder: enableBorder
              ? _buildBorder(borderColor ?? Colors.transparent)
              : InputBorder.none,
          disabledBorder: enableBorder
              ? _buildBorder(borderColor ?? Colors.transparent)
              : InputBorder.none,
          focusedBorder: enableBorder
              ? _buildBorder(borderColor ?? AppColorManager.primary)
              : InputBorder.none,
          border: enableBorder
              ? _buildBorder(borderColor ?? AppColorManager.primary)
              : InputBorder.none,
        ),
        style:
            textStyle ??
            TextStyle(
              color: AppColorManager.dark,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamilyManager.urbanist,
            ),
      ),
    );
  }
}
