import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppGlobalState(),
      child: MaterialApp(
        title: "Nice words",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const HomePage(),
      ),
    );
  }
}

final class MyAppGlobalState extends ChangeNotifier {
  var currentWordPair = WordPair.random();

  void nextWord() {
    currentWordPair = WordPair.random();
    notifyListeners();
  }
}

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppGlobalState>();

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('A random idea'),
          Text('${appState.currentWordPair.toLowerCase()}'),
          ElevatedButton(
            onPressed: () => appState.nextWord(),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
