import 'package:first_app/pages/main_screen.dart';
import 'package:first_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SettingsProvider settingsProvider = SettingsProvider();

  @override
  void initState() {
    super.initState();
    // Listen to changes and rebuild
    settingsProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settingsProvider.themeData,
      home: MainScreen(settingsProvider: settingsProvider),
    );
  }
}
