import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_social_feed/core/constants/app_constant_manager.dart';

class AppNavigator {
  static void push(Widget page) {
    Get.to(
      () => page,
      transition: AppConstantManager.kTransition,
      duration: AppConstantManager.kTransitionDuration,
    );
  }

  static void pushNamed(String routeName, {dynamic arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  static void pushReplacement(Widget page) {
    Get.off(
      () => page,
      transition: AppConstantManager.kTransition,
      duration: AppConstantManager.kTransitionDuration,
      curve: Curves.easeIn,
    );
  }

  static void pushReplacementNamed(String routeName, {dynamic arguments}) {
    Get.offNamed(routeName, arguments: arguments);
  }

  static void pushAndRemoveUntil(Widget page) {
    Get.offAll(
      () => page,
      transition: AppConstantManager.kTransition,
      duration: AppConstantManager.kTransitionDuration,
    );
  }

  static void pushNamedAndRemoveUntil(String routeName) {
    Get.offAllNamed(routeName);
  }
}
