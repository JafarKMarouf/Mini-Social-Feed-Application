import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // --- 2. Save Operations ---
  Future<bool> set<T>(String key, T value) async {
    if (value is String) {
      return await _preferences.setString(key, value);
    } else if (value is bool) {
      return await _preferences.setBool(key, value);
    } else if (value is int) {
      return await _preferences.setInt(key, value);
    } else if (value is double) {
      return await _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      return await _preferences.setStringList(key, value);
    }
    throw Exception('Unsupported type for SharedPreferences');
  }

  // --- 3. Read Operations ---

  T? get<T>(String key) {
    return _preferences.get(key) as T?;
  }

  // --- 4. Delete/Clear Operations ---

  Future<bool> removeKey(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> clearAll() async {
    return await _preferences.clear();
  }
}
