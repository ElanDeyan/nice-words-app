import 'package:flutter/material.dart';
import 'package:myapp/constants/color_pallete.dart';
import 'package:myapp/constants/theme_mode.dart';
import 'package:myapp/helpers/color_pallete_from_string.dart';
import 'package:myapp/helpers/theme_mode_from_string.dart';
import 'package:myapp/services/local_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalPreferencesWithSharedPreferences implements LocalPreferences {
  const LocalPreferencesWithSharedPreferences();

  @override
  Future<ThemeMode> get themeMode async {
    final prefs = await SharedPreferences.getInstance();
    final localThemeMode = prefs.getString(themeModePreferencesKey);

    if (localThemeMode != null) {
      return themeModeFromString(localThemeMode);
    } else {
      return defaultThemeMode;
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(themeModePreferencesKey, themeMode.name);
  }

  @override
  Future<ColorPallete> get colorPallete async {
    final prefs = await SharedPreferences.getInstance();
    final localColorPallete = prefs.getString(colorPalletePreferencesKey);

    if (localColorPallete != null) {
      return colorPalleteFromString(localColorPallete);
    } else {
      return defaultColorPallete;
    }
  }

  @override
  Future<void> setColorPallete(ColorPallete colorPallete) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(colorPalletePreferencesKey, colorPallete.name);
  }
}
