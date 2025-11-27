import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';

Widget buildLoadingOverlay(bool showLoading) {
  if (showLoading) {
    return const Positioned.fill(
      child: ColoredBox(
        color: Colors.black26,
        child: Center(
          child: CircularProgressIndicator(color: AppColorManager.primary),
        ),
      ),
    );
  }
  return const SizedBox.shrink();
}
