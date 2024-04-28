import 'package:flutter/material.dart';
import 'package:myapp/constants/color_pallete.dart';

abstract interface class LocalPreferences {
  Future<ThemeMode> get themeMode;

  Future<void> setThemeMode(ThemeMode themeMode);

  Future<ColorPallete> get colorPallete;

  Future<void> setColorPallete(ColorPallete colorPallete);
}
