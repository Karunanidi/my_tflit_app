import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferenceUtils {
  ///==========================================
  ///
  static const String userScore = 'score';

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // Call this method from initState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<String> getString(String key, String defValue) async {
    var prefs = await _instance;
    return prefs.getString(key) ?? defValue;
  }

  static Future<bool> getBool(String key, bool defValue) async {
    var prefs = await _instance;
    return prefs.getBool(key) ?? defValue;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<bool> setListObject(String key, List<String> value) async {
    var prefs = await _instance;
    return prefs.setStringList(key, value);
  }

  static Future<List<String>> getListObject(String key, List<String> defValue) async {
    var prefs = await _instance;
    return prefs.getStringList(key) ?? defValue;
  }
}
