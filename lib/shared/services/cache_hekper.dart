import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // Ensure initialization before use
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Get a String value
  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  // Save data by key
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return sharedPreferences.setDouble(key, value);
    }
    throw ArgumentError('Invalid value type');
  }

  // Retrieve any type of data
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // Remove data by key
  Future<bool> removeData({required String key}) async {
    return sharedPreferences.remove(key);
  }

  // Check if key exists
  bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  // Clear all data
  Future<bool> clearData() async {
    return sharedPreferences.clear();
  }

  // Save data dynamically
  Future<bool> put({required String key, required dynamic value}) async {
    if (value is String) {
      return sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return sharedPreferences.setDouble(key, value);
    } else {
      throw ArgumentError("Unsupported value type");
    }
  }
}
