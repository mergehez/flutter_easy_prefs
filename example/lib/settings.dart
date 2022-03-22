import 'package:easy_prefs/easy_prefs.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'settings.g.dart';

enum LanguageCodes { kmr, de, en }

@PrefsAnnotation(
  {
    "username": "",
    "notification": true,
    "notificationSound": true,
    "exchangeRate": 1.1,
    "language": LanguageCodes.kmr,
    "likeCount": 0,
    "favs": PrefsStringList(["asf", "afsaf"]),
    "favs2": ["asf", "afsaf"],
  },
  changeNotifier: true,
  onlyModifier: true,
  providerExtensionMethods: true,
  toggleMethodForBoolValues: true,
)
class Settings extends _$Settings {
  Settings() : super();
  Settings.silent() : super(silent: true);
}
