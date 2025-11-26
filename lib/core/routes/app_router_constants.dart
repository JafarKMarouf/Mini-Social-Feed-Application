class AppRouteNames {
  // --- Intro Routes ---
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';

  // --- Auth Routes ---
  static const String login = 'login';
  static const String register = 'register';

  // --- Nav Bar Routes ---
  static const String home = 'home';
  static const String tasks = 'tasks';
  static const String calendar = 'calendar';
  static const String settings = 'settings';
  static const String detail = 'detail';
}

class AppRoutePaths {
  // --- Intro Paths ---
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // --- Auth Paths ---
  static const String login = '/login';
  static const String register = '/register';

  // --- Nav Bar Paths ---
  static const String home = '/home';
  static const String tasks = '/tasks';
  static const String calendar = '/calendar';
  static const String settings = '/settings';

  // This is now a relative path, used as a sub-route of 'home'
  static const String detail = 'todo/:id';
}
