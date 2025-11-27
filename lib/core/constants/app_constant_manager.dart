import 'package:get/get.dart';

abstract class AppConstantManager {
  static const kTransitionDuration = Duration(milliseconds: 200);
  static const kTransition = Transition.fadeIn;
  static const String localeLanguageCode = 'languageCode';

  static const accessTokenKey = 'access_token';
  static const refreshTokenKey = 'refresh_token';
}
