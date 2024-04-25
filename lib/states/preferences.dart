import 'package:flutter/material.dart';
import 'package:myapp/constants/color_pallete.dart';
import 'package:myapp/constants/theme_mode.dart';
import 'package:myapp/helpers/color_pallete_from_string.dart';
import 'package:myapp/helpers/theme_mode_from_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AppPreferences extends ChangeNotifier {
  AppPreferences({
    required LocalPreferences localPreferences,
  }) : _localPreferences = localPreferences;

  final LocalPreferences _localPreferences;

  Future<ThemeMode> get themeMode async => await _localPreferences.themeMode;

  set themeMode(Future<ThemeMode> themeMode) {
    _localPreferences.setThemeMode(themeMode as ThemeMode);
    notifyListeners();
  }

  Future<ColorPallete> get colorPallete async =>
      await _localPreferences.colorPallete;

  set colorPallete(Future<ColorPallete> colorPallete) {
    _localPreferences.setColorPallete(colorPallete as ColorPallete);
    notifyListeners();
  }

  Future<void> toggleThemeMode() async {
    final themeMode = await _localPreferences.themeMode;
    switch (themeMode) {
      case ThemeMode.light:
        _localPreferences.setThemeMode(ThemeMode.light);
      case ThemeMode.dark:
        _localPreferences.setThemeMode(ThemeMode.dark);
      case ThemeMode.system:
        _localPreferences.setThemeMode(ThemeMode.system);
    }
    notifyListeners();
  }
}

sealed class LocalPreferences {
  Future<ThemeMode> get themeMode;

  Future<void> setThemeMode(ThemeMode themeMode);

  Future<ColorPallete> get colorPallete;

  Future<void> setColorPallete(ColorPallete colorPallete);
}

final class SharedPreferencesService implements LocalPreferences {
  @override
  Future<ThemeMode> get themeMode async {
    final prefs = await SharedPreferences.getInstance();
    final localThemeMode = prefs.getString('themeMode');

    if (localThemeMode != null) {
      return themeModeFromString(localThemeMode);
    } else {
      return defaultThemeMode;
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeMode', themeMode.name);
  }

  @override
  Future<ColorPallete> get colorPallete async {
    final prefs = await SharedPreferences.getInstance();
    final localColorPallete = prefs.getString('colorPallete');

    if (localColorPallete != null) {
      return colorPalleteFromString(localColorPallete);
    } else {
      return defaultColorPallete;
    }
  }

  @override
  Future<void> setColorPallete(ColorPallete colorPallete) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('colorPallete', colorPallete.name);
  }
}
