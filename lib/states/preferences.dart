import 'package:flutter/material.dart';
import 'package:myapp/constants/color_pallete.dart';
import 'package:myapp/constants/theme_mode.dart';
import 'package:myapp/services/local_preferences.dart';

final class AppPreferences extends ChangeNotifier {
  AppPreferences({
    required LocalPreferences localPreferencesHandler,
  })  : _localPreferencesHandler = localPreferencesHandler,
        _themeMode = defaultThemeMode,
        _colorPallete = defaultColorPallete;
  final LocalPreferences _localPreferencesHandler;

  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    Future.microtask(() => _localPreferencesHandler.setThemeMode(themeMode));
    notifyListeners();
  }

  void toggleThemeMode() {
    switch (_themeMode) {
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        Future.microtask(
          () => _localPreferencesHandler.setThemeMode(ThemeMode.dark),
        );
      case ThemeMode.dark:
        _themeMode = ThemeMode.system;
        Future.microtask(
          () => _localPreferencesHandler.setThemeMode(ThemeMode.system),
        );
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
        Future.microtask(
          () => _localPreferencesHandler.setThemeMode(ThemeMode.light),
        );
    }
    notifyListeners();
  }

  ColorPallete _colorPallete;

  ColorPallete get colorPallete => _colorPallete;

  set colorPallete(ColorPallete colorPallete) {
    _colorPallete = colorPallete;
    Future.microtask(
      () => _localPreferencesHandler.setColorPallete(colorPallete),
    );
    notifyListeners();
  }
}
