Flutter code generator for generating easy-to-use shared_preferences.

[![Pub Package](https://img.shields.io/pub/v/easy_prefs.svg)](https://pub.dev/packages/easy_prefs)

- [Running the code generator](#running-the-code-generator)
- [Example](#example)
- [PrefsAnnotation](#prefsannotation)
  - [Parameters](#parameters)
  - [PrefsStringList](#prefsstringlist)

## Setup
Add `easy_prefs` and `shared_preferences` to dependencies,  `easy_prefs_gen` and `build_runner` to dev_dependencies.
Note: Add `provider` as well if you're going to use [PrefsAnnotation] with [providerExtensionMethods] set to true.

```yaml
dependencies:
 easy_prefs: [version]
 shared_preferences: ^2.0.11

dev_dependencies:
 build_runner: [version]
 easy_prefs_gen: [version]
```

in your `main.dart` file

```dart
// IMPORT THESE TWO PACKAGES
import 'package:easy_prefs/easy_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // ADD THESE TWO LINES
  WidgetsFlutterBinding.ensureInitialized(); 
  await EasyPrefs.initialize(await SharedPreferences.getInstance());

  // ..

  runApp(const MyApp());
}
```

---

# Running the code generator

Once you have added the annotations to your code you then need to run the code
generator to generate the missing `.g.dart` generated dart files.

```bash
	flutter pub run build_runner build
	
	// or watch
	flutter pub run build_runner watch
```

---

# Example

Given a dart file `example.dart` with an `Settings` class annotated with [`PrefsAnnotation`]:

```dart

import 'package:easy_prefs/easy_prefs.dart';
import 'package:flutter/material.dart'; // or cupertiono, this is required if [changeProvider] is set to true
import 'package:provider/provider.dart'; // this is required if [providerExtensionMethods] is set to true

part 'example.g.dart';

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
class Settings extends _$Settings {}
```

Building creates the corresponding part `example.g.dart`:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

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

```

Consuming the class `main.dart` (Hier I used provider for state management)

```dart
import 'package:easy_prefs/easy_prefs.dart';
import 'package:easy_prefs_example/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // IMPORTANT
  await EasyPrefs.initialize(await SharedPreferences.getInstance());  // IMPORTANT
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyPrefs Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => Settings(),
        builder: (_, __) {
          return const MyHomePage();
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.watchSettings();
    final lastValInFavList = int.parse(settings.favs.isNotEmpty ? settings.favs.last : "0");
    return Scaffold(
      appBar: AppBar(
        title: const Text("EasyPrefs Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CheckboxListTile(
                value: settings.notification,
                title: const Text("Enable notification"),
                onChanged: (t) => settings.notification = t!,
              ),
              CheckboxListTile(
                value: settings.notificationSound,
                title: const Text("Enable notification sound"),
                onChanged: (t) => settings.notificationSound = t!,
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text("Language"),
                trailing: DropdownButton(
                  value: settings.language,
                  items: LanguageCodes.values
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name, textScaleFactor: 1.2),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (LanguageCodes? lang) {
                    if (lang != null) {
                      settings.language = lang;
                    }
                  },
                ),
              ),
              const Divider(height: 1),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("View Count: ", textScaleFactor: 1.2),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () => settings.likeCount--, icon: const Icon(Icons.remove)),
                  Text(settings.likeCount.toString(), textScaleFactor: 1.2),
                  IconButton(onPressed: () => settings.likeCount++, icon: const Icon(Icons.add)),
                ],
              ),
              const Divider(height: 1),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Fav Items: ", textScaleFactor: 1.2),
                  ),
                  const Spacer(),
                  ElevatedButton(onPressed: () => settings.favs.removeLast(), child: const Icon(Icons.remove)),
                  const SizedBox(width: 5),
                  ElevatedButton(onPressed: () => settings.favs.add("${lastValInFavList + 1}"), child: const Icon(Icons.add)),
                ],
              ),
              const Divider(height: 20),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text("settings.toString() :", textScaleFactor: 1.1),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Text(settings.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

---

# PrefsAnnotation
## Parameters
## PrefsStringList
<!-- TODO -->
