import 'package:flutter/material.dart';
import 'package:myapp/screens/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension on ThemeMode {
  static ThemeMode fromString(String themeModeName) => switch (themeModeName) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => ThemeMode.system,
      };
}

final class AppPreferences extends ChangeNotifier {
  AppPreferences({
    ThemeMode themeMode = ThemeMode.system,
    ColorPallete colorPallete = ColorPallete.blue,
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        _themeMode = themeMode,
        _colorPallete = colorPallete;

  final SharedPreferences _prefs;

  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  ColorPallete _colorPallete;

  ColorPallete get colorPallete => _colorPallete;

  set colorPallete(ColorPallete colorPallete) {
    _colorPallete = colorPallete;
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  Future<void> setColorPallete(ColorPallete colorPallete) async {
    await _prefs.setString('colorPallete', colorPallete.name);
    _colorPallete = colorPallete;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _prefs.setString('themeMode', themeMode.name);
    _themeMode = themeMode;
    notifyListeners();
  }

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
