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

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> remove(String key) {
    return _prefsInstance!.remove(key);
  }

  static List<String> getList(String key, [List<String> defValue = const []]) {
    return _prefsInstance!.getStringList(key) ?? defValue;
  }

  static Future<bool> setList(String key, List<String> value) async {
    var prefs = await _instance;
    return prefs.setStringList(key, value);
  }
}