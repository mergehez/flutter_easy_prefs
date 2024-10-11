import 'package:easy_prefs/easy_prefs.dart';
import 'package:easy_prefs_example/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyPrefs.initialize(await SharedPreferences.getInstance());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watchSettings();
    final lastValInFavList =
        int.parse(settings.favs.isNotEmpty ? settings.favs.last : "0");
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
                            value: e,
                            child: Text(e.name,
                                textScaler: TextScaler.linear(1.2)),
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
                    child: Text("View Count: ",
                        textScaler: TextScaler.linear(1.2)),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () => settings.likeCount--,
                      icon: const Icon(Icons.remove)),
                  Text(settings.likeCount.toString(),
                      textScaler: TextScaler.linear(1.2)),
                  IconButton(
                      onPressed: () => settings.likeCount++,
                      icon: const Icon(Icons.add)),
                ],
              ),
              const Divider(height: 1),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        Text("Fav Items: ", textScaler: TextScaler.linear(1.2)),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () => settings.favs.removeLast(),
                      child: const Icon(Icons.remove)),
                  const SizedBox(width: 5),
                  ElevatedButton(
                      onPressed: () =>
                          settings.favs.add("${lastValInFavList + 1}"),
                      child: const Icon(Icons.add)),
                ],
              ),
              const Divider(height: 20),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text("settings.toString() :",
                    textScaler: TextScaler.linear(1.1)),
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
