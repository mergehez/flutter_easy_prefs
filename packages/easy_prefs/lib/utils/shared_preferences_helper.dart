part of '../easy_prefs.dart';

class SharedPreferencesHelper {
  static dynamic __prefs;
  dynamic get _prefs => __prefs!;
  void Function(String key)? onNotify;

  SharedPreferencesHelper()
      : assert(__prefs != null,
            'You must call "await EasyPrefs.initialize(await SharedPreferences.getInstance());" in the main method of your project!');

  String getString(String key, String defaultValue) => _prefs.getString(key) ?? defaultValue;
  void setString(String key, String value, [void Function(String)? then]) => _setT(key, value, getString, _prefs.setString, then);

  int getInt(String key, int defaultValue) => _prefs.getInt(key) ?? defaultValue;
  void setInt(String key, int value, [void Function(int)? then]) => _setT(key, value, getInt, _prefs.setInt, then);

  double getDouble(String key, double defaultValue) => _prefs.getDouble(key) ?? defaultValue;
  void setDouble(String key, double value, [void Function(double)? then]) => _setT(key, value, getDouble, _prefs.setDouble, then);

  bool getBool(String key, bool defaultValue) => _prefs.getBool(key) ?? defaultValue;
  void setBool(String key, bool value, [void Function(bool)? then]) => _setT(key, value, getBool, _prefs.setBool, then);

  NotifiableStringList getStringList(String key, List<String> defaultValue) {
    return NotifiableStringList(_prefs.getStringList(key) ?? defaultValue, (list) => setStringList(key, list));
  }

  void setStringList(String key, List<String> value, [void Function(List<String>)? then]) =>
      _setT(key, value, getStringList, _prefs.setStringList, then);

  void _setT<TValue>(String key, TValue value, TValue Function(String key, TValue defaultValue) getter,
      Future<bool> Function(String key, TValue defaultValue) setter, void Function(TValue)? then) {
    if (!hasKey(key) || getter(key, value) != value) {
      setter(key, value).then((_) {
        then?.call(value);
        onNotify?.call(key);
      });
    }
  }

  bool toggleBool(String key, bool defaultValue, [void Function(bool)? then]) {
    final newValue = !getBool(key, defaultValue);
    setBool(key, newValue, then);
    return newValue;
  }

  TEnum getEnum<TEnum extends Enum>(String key, List<TEnum> allEnumValues, TEnum defaultValue) {
    var val = getInt(key, defaultValue.index);
    if (val < 0 || val >= allEnumValues.length) {
      return defaultValue;
    }

    return allEnumValues[val];
  }

  bool hasKey(String key) => _prefs.containsKey(key);

  bool hasKeyByValueCheck(String key, String defaultValue) => (_prefs.getString(key) ?? defaultValue) != defaultValue;
}
