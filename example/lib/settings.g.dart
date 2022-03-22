// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// PrefsGenerator
// **************************************************************************

class _PrefKeysForSettings {
  const _PrefKeysForSettings();
  final String username = 'username';
  final String notification = 'notification';
  final String notificationSound = 'notificationSound';
  final String exchangeRate = 'exchangeRate';
  final String language = 'language';
  final String likeCount = 'likeCount';
  final String favs = 'favs';
  final String favs2 = 'favs2';
}

class _$Settings with IEasyPrefs, ChangeNotifier {
  final _helper = SharedPreferencesHelper();
  final _keys = const _PrefKeysForSettings();

  /// if [silent] is true, value changes won't be notified.
  _$Settings({bool silent = false}) {
    if (silent) return;
    _helper.onNotify = onValueChanged;
  }

  @override
  void onValueChanged(String key) {
    notifyListeners();
  }

  String? _$username;
  String get username => _$username ?? _helper.getString(_keys.username, '');
  set username(String val) => _helper.setString(_keys.username, val, (_) => _$username = val);

  bool? _$notification;
  bool get notification => _$notification ?? _helper.getBool(_keys.notification, true);
  set notification(bool val) => _helper.setBool(_keys.notification, val, (_) => _$notification = val);
  bool toggleNotification() => _helper.toggleBool(_keys.notification, true, (val) => _$notification = val);

  bool? _$notificationSound;
  bool get notificationSound => _$notificationSound ?? _helper.getBool(_keys.notificationSound, true);
  set notificationSound(bool val) => _helper.setBool(_keys.notificationSound, val, (_) => _$notificationSound = val);
  bool toggleNotificationSound() => _helper.toggleBool(_keys.notificationSound, true, (val) => _$notificationSound = val);

  double? _$exchangeRate;
  double get exchangeRate => _$exchangeRate ?? _helper.getDouble(_keys.exchangeRate, 1.1);
  set exchangeRate(double val) => _helper.setDouble(_keys.exchangeRate, val, (_) => _$exchangeRate = val);

  LanguageCodes? _$language;
  LanguageCodes get language => _$language ?? _helper.getEnum(_keys.language, LanguageCodes.values, LanguageCodes.kmr);
  set language(LanguageCodes val) => _helper.setInt(_keys.language, val.index, (_) => _$language = val);

  int? _$likeCount;
  int get likeCount => _$likeCount ?? _helper.getInt(_keys.likeCount, 0);
  set likeCount(int val) => _helper.setInt(_keys.likeCount, val, (_) => _$likeCount = val);

  NotifiableStringList? _$favs;
  NotifiableStringList get favs => _$favs ?? _helper.getStringList(_keys.favs, ['asf', 'afsaf']);
  set favs(NotifiableStringList val) => _helper.setStringList(_keys.favs, val, (_) => _$favs = val);

  NotifiableStringList? _$favs2;
  NotifiableStringList get favs2 => _$favs2 ?? _helper.getStringList(_keys.favs2, ['asf', 'afsaf']);
  set favs2(NotifiableStringList val) => _helper.setStringList(_keys.favs2, val, (_) => _$favs2 = val);

  @override
  void initializeAll() {
    final _tmp = _helper.onNotify;
    _helper.onNotify = null;

    username = username;
    notification = notification;
    notificationSound = notificationSound;
    exchangeRate = exchangeRate;
    language = language;
    likeCount = likeCount;
    favs = favs;
    favs2 = favs2;

    _helper.onNotify = _tmp;
    _helper.onNotify?.call("");
  }

  @override
  bool isTouched() {
    return _helper.hasKey(_keys.username) ||
        _helper.hasKey(_keys.notification) ||
        _helper.hasKey(_keys.notificationSound) ||
        _helper.hasKey(_keys.exchangeRate) ||
        _helper.hasKey(_keys.language) ||
        _helper.hasKey(_keys.likeCount) ||
        _helper.hasKey(_keys.favs) ||
        _helper.hasKey(_keys.favs2);
  }

  @override
  String toString() {
    return '''
{
  "username" : "$username",
  "notification" : $notification,
  "notificationSound" : $notificationSound,
  "exchangeRate" : $exchangeRate,
  "language" : $language,
  "likeCount" : $likeCount,
  "favs" : [
      ${favs.map((e) => '"$e"').join(",\n      ")}
    ],
  "favs2" : [
      ${favs2.map((e) => '"$e"').join(",\n      ")}
    ]
}
''';
  }
}

extension SettingsProviderExtensionMethodsOnBuildContext on BuildContext {
  Settings readSettings() => read<Settings>();
  Settings watchSettings() => watch<Settings>();
  R selectSettings<R>(R Function(Settings s) selector) => select(selector);
}
