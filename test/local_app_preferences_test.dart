import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/constants/color_pallete.dart';
import 'package:myapp/constants/theme_mode.dart';
import 'package:myapp/services/shared_preferences_service.dart';
import 'package:myapp/states/local_app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final mockPreferences = <String, String>{
  colorPalletePreferencesKey: ColorPallete.red.name,
  themeModePreferencesKey: ThemeMode.dark.name,
};

void main() async {
  SharedPreferences.setMockInitialValues(mockPreferences);
  const localPreferencesHandler = LocalPreferencesWithSharedPreferences();
  final appPreferences = AppPreferences(
    localPreferencesHandler: localPreferencesHandler,
  );

  group('Getters', () {
    test('ThemeMode', () {
      expect(appPreferences.themeMode, equals(ThemeMode.dark));
    });

    test('ColorPallete', () {
      expect(appPreferences.colorPallete, equals(ColorPallete.red));
    });
  });

  group('Setters', () {
    const themeModes = ThemeMode.values;

    for (final themeMode in themeModes) {
      test('Setting $themeMode', () {
        appPreferences.themeMode = themeMode;
        expect(appPreferences.themeMode, equals(themeMode));
      });
    }

    const colorPalletes = ColorPallete.values;

    for (final colorPallete in colorPalletes) {
      test('Setting $colorPallete', () {
        appPreferences.colorPallete = colorPallete;
        expect(appPreferences.colorPallete, colorPallete);
      });
    }
  });

  group('Toggle theme mode', () {
    const expectations = <({ThemeMode actual, ThemeMode expectedOnToggle})>[
      (actual: ThemeMode.light, expectedOnToggle: ThemeMode.dark),
      (actual: ThemeMode.dark, expectedOnToggle: ThemeMode.system),
      (actual: ThemeMode.system, expectedOnToggle: ThemeMode.light),
    ];

    for (final (:actual, :expectedOnToggle) in expectations) {
      test('Toggling from ${actual.name} to ${expectedOnToggle.name}', () {
        appPreferences.themeMode = actual;
        expect(appPreferences.themeMode, actual);
        appPreferences.toggleThemeMode();
        expect(appPreferences.themeMode, expectedOnToggle);
      });
    }
  });

  group('Are changes saved locally?', () {
    test('Theme mode', () async {
      var localThemeMode = await localPreferencesHandler.themeMode;
      final themeModeValuesExceptLocal =
          ThemeMode.values.where((element) => element != localThemeMode);

      for (final themeModeToAssign in themeModeValuesExceptLocal) {
        // updates [localThemeMode] for the next iteration
        localThemeMode = await localPreferencesHandler.themeMode;

        final oldLocalThemeMode = localThemeMode;
        expect(appPreferences.themeMode, equals(oldLocalThemeMode));

        appPreferences.themeMode = themeModeToAssign;

        // simulates delay to write locally
        await Future.delayed(
          const Duration(milliseconds: 250),
        );

        expect(appPreferences.themeMode, equals(themeModeToAssign));

        final newLocalThemeMode = await localPreferencesHandler.themeMode;
        expect(oldLocalThemeMode, isNot(newLocalThemeMode));
      }
    });

    test('Color Pallete', () async {
      var localColorPallete = await localPreferencesHandler.colorPallete;
      final colorPalleteValuesExceptLocal =
          ColorPallete.values.where((element) => element != localColorPallete);

      for (final colorPalleteToAssign in colorPalleteValuesExceptLocal) {
        // updates [localColorPallete] for the next iteration
        localColorPallete = await localPreferencesHandler.colorPallete;

        final oldLocalColorPallete = localColorPallete;
        expect(appPreferences.colorPallete, equals(oldLocalColorPallete));

        appPreferences.colorPallete = colorPalleteToAssign;

        // simulates delay to write locally
        await Future.delayed(
          const Duration(milliseconds: 250),
        );

        expect(appPreferences.colorPallete, equals(colorPalleteToAssign));

        final newLocalColorPallete = await localPreferencesHandler.colorPallete;
        expect(oldLocalColorPallete, isNot(newLocalColorPallete));
      }
    });
  });
}
