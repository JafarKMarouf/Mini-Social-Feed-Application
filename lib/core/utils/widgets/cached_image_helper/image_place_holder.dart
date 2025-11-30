import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';

Widget imagePlaceHolder() => Container(
  width: double.infinity,
  height: AppHeightManager.h27,
  color: AppColorManager.gray,
  child: const Center(
    child: CircularProgressIndicator(
      strokeWidth: 3,
      color: AppColorManager.primary,
    ),
  ),
);
