import 'package:first_app/utils/translations.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _language = 'ភាសាខ្មែរ';

  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  String get language => _language;

  // Toggle dark mode
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  // Toggle notifications
  void setNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  // Set language
  void setLanguage(String value) {
    _language = value;
    notifyListeners();
  }

  // Translate
  String translate(String key) {
    return AppTranslations.translations[_language]?[key] ?? key;
  }

  // Get theme data based on dark mode setting
  ThemeData get themeData {
    if (_isDarkMode) {
      return ThemeData(
        fontFamily: 'KantumruyPro',
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        cardColor: const Color(0xFF1E1E1E),
        canvasColor: const Color(0xFF1E1E1E),
        dialogBackgroundColor: const Color(0xFF1E1E1E),
        dividerColor: Colors.grey[700],
        listTileTheme: ListTileThemeData(
          textColor: Colors.white,
          iconColor: Colors.grey[400],
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.grey),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.grey[400]),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.teal;
            }
            return Colors.grey;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.teal.withOpacity(0.5);
            }
            return Colors.grey.withOpacity(0.3);
          }),
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.teal,
          secondary: Colors.tealAccent,
          surface: Color(0xFF1E1E1E),
        ),
      );
    } else {
      return ThemeData(
        fontFamily: 'KantumruyPro',
        brightness: Brightness.light,
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.white,
        canvasColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        dividerColor: Colors.grey[200],
        listTileTheme: ListTileThemeData(
          textColor: Colors.grey[800],
          iconColor: Colors.grey[700],
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.grey[800]),
          bodyMedium: TextStyle(color: Colors.grey[800]),
          bodySmall: TextStyle(color: Colors.grey[600]),
          titleLarge: TextStyle(color: Colors.grey[800]),
          titleMedium: TextStyle(color: Colors.grey[800]),
          titleSmall: TextStyle(color: Colors.grey[800]),
        ),
        iconTheme: IconThemeData(color: Colors.grey[700]),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.teal;
            }
            return Colors.grey;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.teal.withOpacity(0.5);
            }
            return Colors.grey.withOpacity(0.3);
          }),
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.tealAccent,
          surface: Colors.white,
        ),
      );
    }
  }
}
