import 'package:flutter/material.dart';
import 'package:myapp/screens/main_view.dart';
import 'package:myapp/services/local_preferences.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
          create: (context) => AppPreferences(
            localPreferencesHandler: SharedPreferencesService(),
          ),
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
  @override
  Widget build(BuildContext context) {
    final appPreferences = Provider.of<AppPreferences>(context);

    return MaterialApp(
      title: "Nice words",
      debugShowCheckedModeBanner: false,
      themeMode: appPreferences.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: appPreferences.colorPallete.color),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: appPreferences.colorPallete.color,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainView(),
    );
  }
}
