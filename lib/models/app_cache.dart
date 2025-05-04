import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const klogin = 'flowwow_login';

  /// Invalidate and remove the user session from cache
  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(klogin, false);
  }

  /// Cache user login state
  Future<void> cacheUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(klogin, true);
  }

  /// Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(klogin) ?? false;
  }
}