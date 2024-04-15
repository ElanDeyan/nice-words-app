import 'package:flutter/material.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';

void main() {
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
              AppPreferences(themeMode: ThemeMode.system),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}
