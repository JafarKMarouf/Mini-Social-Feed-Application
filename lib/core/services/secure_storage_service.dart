import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mini_social_feed/core/constants/app_constant_manager.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // --- 2. Save Operations ---

  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: AppConstantManager.accessTokenKey, value: token);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: AppConstantManager.refreshTokenKey, value: token);
  }

  // Check if access token exists
  static Future<bool> hasAccessToken() async {
    try {
      final token = await _storage.read(key: AppConstantManager.accessTokenKey);
      return token != null && token.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking access token: $e');
    }
  }

  // Check if refresh token exists
  static Future<bool> hasRefreshToken() async {
    try {
      final token = await _storage.read(
        key: AppConstantManager.refreshTokenKey,
      );
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  // --- 3. Read Operations ---

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: AppConstantManager.accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: AppConstantManager.refreshTokenKey);
  }

  // --- 4. Delete/Clear Operations ---

  static Future<void> deleteKey(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAllTokens() async {
    await deleteKey(AppConstantManager.accessTokenKey);
    await deleteKey(AppConstantManager.refreshTokenKey);
  }
}
