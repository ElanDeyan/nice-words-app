import 'package:flutter/material.dart';

final class AppPreferences extends ChangeNotifier {
  AppPreferences({ThemeMode themeMode = ThemeMode.light})
      : _themeMode = themeMode;
  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    switch (themeMode) {
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
      case ThemeMode.dark:
        _themeMode = ThemeMode.system;
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
