import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/constants/user_favorites.dart';
import 'package:myapp/services/user_favorites_with_shared_preferences.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('GeneratedWords', (widgetTester) async {
    SharedPreferences.setMockInitialValues(mockPreferences);
    const userFavoritesHandler = UserFavoritesWithSharedPreferences();
    final generatedWords =
        GeneratedWords(userFavoritesHandler: userFavoritesHandler);

    await widgetTester.pumpWidget(
      ChangeNotifierProvider.value(
        value: generatedWords,
        child: const MaterialApp(
          home: GeneratedWordsTest(),
        ),
      ),
    );

    expect(find.byType(Card), findsOneWidget);

    expect(find.byKey(const Key('history')), findsNothing);

    await widgetTester.tap(find.byKey(const Key('nextWord')));

    await widgetTester.pumpAndSettle();
  });
}

final mockPreferences = <String, List<String>>{
  userFavoritesKey: [WordPair.random().asSnakeCase],
};

final class GeneratedWordsTest extends StatelessWidget {
  const GeneratedWordsTest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<GeneratedWords>(
        builder: (context, value, child) {
          return Column(
            children: [
              const Text('Favorites:'),
              Row(
                key: const Key('favorites'),
                children: <Widget>[
                  ...value.favorites.map(
                    (element) => Chip(
                      label: Text(element.asCamelCase),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Card(
                key: const Key('actualRandomWord'),
                child: Text(value.currentWordPair.asCamelCase),
              ),
              const Divider(),
              const Text('history'),
              if (value.wordPairHistory.isNotEmpty)
                Row(
                  key: const Key('history'),
                  children: [
                    ...value.wordPairHistory
                        .map((element) => Text(element.asCamelCase)),
                  ],
                ),
              ElevatedButton(
                onPressed: () => value.nextWord(),
                key: const Key('nextWord'),
                child: const Text('Next'),
              ),
              ElevatedButton(
                onPressed: () => value.toggleFavorites(value.currentWordPair),
                key: const Key('like'),
                child: const Text('Like'),
              ),
            ],
          );
        },
      ),
    );
  }
}
