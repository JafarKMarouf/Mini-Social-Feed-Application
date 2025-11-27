import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';

abstract class AppTextStyle {
  static TextStyle styleUrbanistSemiBold14(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.darkGray,
    );
  }

  static TextStyle styleUrbanistSemiBold15(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.white,
    );
  }

  static TextStyle styleUrbanistMedium15(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.gray,
    );
  }

  static TextStyle styleUrbanistMedium16(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.gray,
    );
  }

  static TextStyle styleUrbanistBold15(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.primary,
    );
  }

  static TextStyle styleUrbanistBold17(BuildContext context) {
    return const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.primary,
    );
  }

  static TextStyle styleUrbanistBold22(BuildContext context) {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.dark,
    );
  }

  static TextStyle styleUrbanistBold26(BuildContext context) {
    return const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.dark,
    );
  }

  static TextStyle styleUrbanistBold30(BuildContext context) {
    return const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      fontFamily: FontFamilyManager.urbanist,
      color: AppColorManager.dark,
    );
  }
}
