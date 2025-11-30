import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GetIt.instance<GoRouter>();

class AppNavigator {
  static void pushNamed(
    String routeName, {
    Map<String, String>? pathParameters,
  }) {
    _router.pushNamed(routeName, pathParameters: pathParameters ?? {});
  }

  static void goNamed(String routeName, {Object? extra}) {
    _router.go(routeName, extra: extra);
  }

  static void pushReplacementNamed(String routeName, {Object? extra}) {
    _router.go(routeName, extra: extra);
  }

  static void pushNamedAndRemoveUntil(String routeName, {Object? extra}) {
    _router.go(routeName, extra: extra);
  }

  static void pop({bool isRoot = false}) {
    _router.pop(isRoot);
  }
}
