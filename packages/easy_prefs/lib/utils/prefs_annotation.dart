part of '../easy_prefs.dart';

class PrefsAnnotation {
  /// Keys of map are converted to properties. So they must be valid property names.
  ///
  /// Values in map are default values for keys.
  ///
  /// Supported data types for values: [int], [double], [bool], [String], [PrefsStringList] and [List\<String\>]
  final Map<String, Object> map;

  /// Indicates whether the generated class should extend [ChangeNotifier] class, which is used for state management. Default value is `true`
  final bool changeNotifier;

  /// Indicates whether this class is the only manager of the given preferences. Default value is `true`
  ///
  /// If set to true, static private variables will be created for each preference and the getter will just return them.
  /// This means that you won't have to care about unnecessary calls to shared preferences.
  ///
  /// If set to false, you should create local variable each time to prevent constant calls to shared preferences.
  /// For more information: https://dart.dev/guides/language/effective-dart/design#do-use-getters-for-operations-that-conceptually-access-properties
  ///
  /// If this is set to true:
  /// ```dart
  ///   bool? _$notification;
  ///   bool get notification => _$notification ?? _helper.getBool(_keys.notification, true);
  ///   set notification(bool val) => _helper.setBool(_keys.notification, val, (_) => _$notification = val);
  ///   bool toggleNotification() => _helper.toggleBool(_keys.notification, true, (val) => _$notification = val);
  /// ```
  ///
  /// If set to false
  /// ```dart
  ///   bool get notification => _helper.getBool(_keys.notification, true);
  ///   set notification(bool val) => _helper.setBool(_keys.notification, val);
  ///   bool toggleNotification() => _helper.toggleBool(_keys.notification, true); // this line
  /// ```
  ///
  ///
  final bool onlyModifier;

  /// Indicates whether extension methods should be created for [provider] on BuildContext. Default value is `false`
  ///
  /// Example usage if methods are generated for a class named `Settings`
  /// ```dart
  ///   final settings = context.watchSettings();
  ///   final settings = context.readSettings();
  ///   final enableSound = context.selectSettings((t) => t.enableSound);
  /// ```
  final bool providerExtensionMethods;

  /// Indicates whether toggle methods should be created for bool values. Default value is `true`
  ///
  /// Example output if it is set to true:
  /// ```dart
  ///   bool get notification => _helper.getBool(_keys.notification, true);
  ///   set notification(bool val) => _helper.setBool(_keys.notification, val);
  ///   bool toggleNotification() => _helper.toggleBool(_keys.notification, true); // this line
  /// ```
  final bool toggleMethodForBoolValues;

  const PrefsAnnotation(
    this.map, {
    this.changeNotifier = true,
    this.onlyModifier = true,
    this.providerExtensionMethods = false,
    this.toggleMethodForBoolValues = false,
  });
}
