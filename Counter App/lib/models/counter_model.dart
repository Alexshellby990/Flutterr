import 'package:popcat/utils/my_prefs.dart';

class Counter {
  int _value;

  Counter([this._value = 0]); // optional positional parameter _value

  static Future<Counter> createFromPref() async {
    int? value = await MyPrefs.getCounterValue();
    return value == null ? Counter() : Counter(value);
  }

  int get value => _value; // getter

  void updateValue(int diff) {
    // disable count to negative numbers
    if (_value + diff >= 0) {
      _value += diff;
      _saveValueToPref();
    }
  }

  void resetValue() {
    _value = 0;
    _saveValueToPref();
  }

  void _saveValueToPref() {
    MyPrefs.setCounterValue(_value);
  }
}
