import 'package:flutter/material.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyAppProvider(localPreferences: prefs));
}

final class MyAppProvider extends StatelessWidget {
  const MyAppProvider({required this.localPreferences, super.key});

  final SharedPreferences localPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GeneratedWords(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppPreferences(prefs: localPreferences),
        ),
      ],
      child: const MyApp(),
    );
  }
}

final class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<AppPreferences>(context);

    return MaterialApp(
      title: "Nice words",
      themeMode: preferences.themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: preferences.colorPallete.color),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: preferences.colorPallete.color,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainView(),
    );
  }
}
