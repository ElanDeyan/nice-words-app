import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/screens/settings_page.dart';
import 'package:myapp/states/preferences.dart';

void main() {
  test('Default values', () {
    final appPreferences = AppPreferences();
    expect(appPreferences.themeMode, ThemeMode.system);
    expect(appPreferences.colorPallete, ColorPallete.blue);
  });

  group('Test themeModes', () {
    const defaultThemeMode = ThemeMode.system;
    final themeModeTestData =
        ThemeMode.values.where((element) => element != defaultThemeMode);

    for (final themeMode in themeModeTestData) {
      test('Setting $themeMode', () {
        final appPreferences = AppPreferences();

        appPreferences.themeMode = themeMode;
        expect(appPreferences.themeMode != defaultThemeMode, equals(true));
        expect(appPreferences.themeMode, equals(themeMode));
      });
    }
  });
  group('Set color pallete', () {
    const defaultColorPallete = ColorPallete.blue;
    final colorPalleteTestData =
        ColorPallete.values.where((element) => element != defaultColorPallete);

    for (final colorPallete in colorPalleteTestData) {
      test('Setting $colorPallete', () {
        final appPreferences = AppPreferences();
        appPreferences.colorPallete = colorPallete;
        expect(
          appPreferences.colorPallete != defaultColorPallete,
          equals(true),
        );
        expect(appPreferences.colorPallete, equals(colorPallete));
      });
    }
  });
}
