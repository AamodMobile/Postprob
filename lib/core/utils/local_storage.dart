import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static resetLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("isSP");
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String? status = prefs.getString('user_name');
    return status;
  }

  static Future<void> setUserName(String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', status);
  }

  static Future<String?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? status = prefs.getString('user_profile');
    return status;
  }

  static Future<void> setUserProfile(String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', status);
  }
}
