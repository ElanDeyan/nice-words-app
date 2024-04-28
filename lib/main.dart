import 'package:flutter/material.dart';
import 'package:myapp/screens/main_view.dart';
import 'package:myapp/services/shared_preferences_service.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const localPreferences = SharedPreferencesService();
  final appPreferences =
      AppPreferences(localPreferencesHandler: localPreferences);
  await appPreferences.loadLocalPreferences();
  runApp(
    MyAppProvider(
      appPreferences: appPreferences,
    ),
  );
}

final class MyAppProvider extends StatelessWidget {
  const MyAppProvider({
    super.key,
    required AppPreferences appPreferences,
  }) : _appPreferences = appPreferences;

  final AppPreferences _appPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GeneratedWords(),
        ),
        ChangeNotifierProvider(
          create: (context) => _appPreferences,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppPreferences>(
      builder: (context, value, child) {
        return MaterialApp(
          title: "Nice words",
          debugShowCheckedModeBanner: false,
          themeMode: value.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: value.colorPallete.color,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: value.colorPallete.color,
              brightness: Brightness.dark,
            ),
          ),
          home: child,
        );
      },
      child: const MainView(),
    );
  }
}
