import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';

Widget imageError() => Container(
  width: double.infinity,
  height: AppHeightManager.h27,
  color: AppColorManager.dark,
  child: const Center(
    child: Icon(Icons.error, color: AppColorManager.darkGray),
  ),
);
