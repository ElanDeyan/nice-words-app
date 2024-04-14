import 'package:flutter/material.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeneratedWords(),
      child: MaterialApp(
        title: "Nice words",
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
      ),
    );
  }
}
