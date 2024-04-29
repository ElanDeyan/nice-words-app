import 'package:flutter/material.dart';

ThemeMode themeModeFromString(String string) => switch (string) {
      'system' => ThemeMode.system,
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => throw ArgumentError.value(string, null, "Unrecognized value"),
    };
