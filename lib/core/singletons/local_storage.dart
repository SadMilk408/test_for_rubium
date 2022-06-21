import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

class LocalStorage {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String defValue = '']) {
    return _prefsInstance!.getString(key) ?? defValue;
  }

  static int getInt(String key, [int defValue = 0]) {
    return _prefsInstance!.getInt(key) ?? defValue;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

}