library easy_prefs;

import 'dart:math';

part 'utils/shared_preferences_helper.dart';
part "utils/prefs_string_list.dart";
part "utils/notifiable_string_list.dart";
part "utils/prefs_annotation.dart";

class EasyPrefs {
  /// Ensure that you've added the dependency ***shared_preferences*** to your project:
  ///
  /// Exact usage:
  /// ```dart
  /// await EasyPrefs.initialize(await SharedPreferences.getInstance());
  /// ```
  static Future<void> initialize(dynamic sharedPreferencesInstance) async {
    SharedPreferencesHelper.__prefs = sharedPreferencesInstance;
  }
}

/// Act as an interface like in other programming languages.
///
/// Has this abstract methods: onValueChanged, initializeAll, isTouched
abstract class IEasyPrefs {
  /// Gets triggered when a value has been changed.
  void onValueChanged(String key);

  /// Initializes all fields. Basically setting to their default values, which were defined in [PrefsAnnotation]
  void initializeAll();

  /// Returns `true` if any preference has been set so far, otherwise `false`
  void isTouched();
}
