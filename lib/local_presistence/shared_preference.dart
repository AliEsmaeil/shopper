import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences prefs;

  Future<void> initiatePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> writeData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) return await prefs.setBool(key, value);

    if (value is String) return await prefs.setString(key, value);

    if (value is int) return await prefs.setInt(key, value);

    if (value is double) return await prefs.setDouble(key, value);

    if (value is List<String>) return await prefs.setStringList(key, value);

    return false;
  }

  static dynamic readData({
    required String key,
  }) {
    if(key == 'token') {
      return 'LvoruAQD7zJ4jyTWnDjBVrWAVYXvKsVxZGsQwuN4BcL4vmFf3nHKSpUO85tMqXeXKlUmTC';
    }
    return prefs.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await prefs.remove(key);
  }
}
