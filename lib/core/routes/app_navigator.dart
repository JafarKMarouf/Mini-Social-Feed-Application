import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  static void push(BuildContext context, String page) {
    GoRouter.of(context).push(page);
  }

  static void pushNamed(
    BuildContext context,
    String page,
    Map<String, String> pathParameters,
  ) {
    context.pushNamed(page, pathParameters: pathParameters);
  }

  static void pushReplacement(BuildContext context, String page) {
    GoRouter.of(context).pushReplacement(page);
  }
}
