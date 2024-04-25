import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/constants/color_pallete.dart';
import 'package:myapp/constants/theme_mode.dart';
import 'package:myapp/helpers/color_pallete_from_string.dart';
import 'package:myapp/helpers/theme_mode_from_string.dart';
import 'package:myapp/screens/main_view.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localPreferences = await SharedPreferences.getInstance();

  if (localPreferences.getString('themeMode') == null) {
    localPreferences.setString('themeMode', defaultThemeMode.name);
  }

  if (localPreferences.getString('colorPallete') == null) {
    localPreferences.setString('colorPallete', defaultColorPallete.name);
  }

  runApp(const MyAppProvider());
}

final class MyAppProvider extends StatelessWidget {
  const MyAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GeneratedWords(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AppPreferences(localPreferences: SharedPreferencesService()),
        ),
      ],
      child: const MyApp(),
    );
  }
}

final class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;
  late ColorPallete _colorPallete;

  @override
  void initState() {
    super.initState();
    _loadLocalPreferences();
  }

  Future<void> _loadLocalPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _themeMode = themeModeFromString(
        prefs.getString('themeMode')!,
      );

      _colorPallete = colorPalleteFromString(
        prefs.getString('colorPallete')!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nice words",
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _colorPallete.color),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _colorPallete.color,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainView(),
    );
  }
}
