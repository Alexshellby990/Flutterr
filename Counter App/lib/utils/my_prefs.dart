import 'package:shared_preferences/shared_preferences.dart';

class MyPrefs {
  static const keyCounterValue = 'counter_value';

  static Future<int?> getCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyCounterValue);
  }

  static Future<void> setCounterValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyCounterValue, value);
  }
}