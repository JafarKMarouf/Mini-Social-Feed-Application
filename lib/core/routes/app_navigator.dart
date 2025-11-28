import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GetIt.instance<GoRouter>();

class AppNavigator {
  static void pushNamed(String routeName, {Object? extra}) {
    _router.push(routeName, extra: extra);
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

  static void pop() {
    _router.pop();
  }

  // static void push(Widget page) {
  //   Get.to(
  //     () => page,
  //     transition: AppConstantManager.kTransition,
  //     duration: AppConstantManager.kTransitionDuration,
  //   );
  // }
  //
  // static void pushNamed(String routeName, {dynamic arguments}) {
  //   Get.toNamed(routeName, arguments: arguments);
  // }
  //
  // static void pushReplacement(Widget page) {
  //   Get.off(
  //     () => page,
  //     transition: AppConstantManager.kTransition,
  //     duration: AppConstantManager.kTransitionDuration,
  //     curve: Curves.easeIn,
  //   );
  // }
  //
  // static void pushReplacementNamed(String routeName, {dynamic arguments}) {
  //   Get.offNamed(routeName, arguments: arguments);
  // }
  //
  // static void pushAndRemoveUntil(Widget page) {
  //   Get.offAll(
  //     () => page,
  //     transition: AppConstantManager.kTransition,
  //     duration: AppConstantManager.kTransitionDuration,
  //   );
  // }
  //
  // static void pushNamedAndRemoveUntil(String routeName) {
  //   Get.offAllNamed(routeName);
  // }
}
