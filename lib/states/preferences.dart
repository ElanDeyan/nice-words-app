import 'package:flutter/material.dart';
import 'package:myapp/screens/settings_page.dart';

final class AppPreferences extends ChangeNotifier {
  AppPreferences({
    ThemeMode themeMode = ThemeMode.system,
    ColorPallete colorPallete = ColorPallete.blue,
  })  : _themeMode = themeMode,
        _colorPallete = colorPallete;

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
