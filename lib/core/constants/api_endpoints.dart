class ApiEndPoints {
  static const String baseUrl = 'http://161.97.64.130:8081/api';

  ///Auth
  static const register = '$baseUrl/register';
  static const login = '$baseUrl/login';
  static const refreshToken = '$baseUrl/token/refresh';
  static const logout = '$baseUrl/logout';
  static const me = '$baseUrl/me';
}
