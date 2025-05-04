import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _biographyKey = 'user_biography';

  static Future<void> saveBiography(String biography) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_biographyKey, biography);
  }

  static Future<String?> getBiography() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_biographyKey);
  }
}
