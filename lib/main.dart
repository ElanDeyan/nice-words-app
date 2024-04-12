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

  final favorites = <WordPair>{};

  void nextWord() {
    currentWordPair = WordPair.random();
    notifyListeners();
  }

  void toggleFavorites(WordPair value) {
    if (favorites.contains(value)) {
      favorites.remove(value);
    } else {
      favorites.add(value);
    }
    notifyListeners();
  }
}

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppGlobalState>();
    final pair = appState.currentWordPair;

    final isFavorited = appState.favorites.contains(pair);

    final icon = isFavorited ? Icons.favorite : Icons.favorite_border;
    final label = isFavorited ? 'Dislike' : 'Like';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BigCard(pair: pair),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => appState.toggleFavorites(pair),
                  child: Row(
                    children: <Widget>[
                      Icon(icon),
                      const SizedBox(width: 4),
                      Text(label),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => appState.nextWord(),
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: textStyle,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
