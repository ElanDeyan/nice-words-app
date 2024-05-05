import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/components/big_card.dart';
import 'package:myapp/components/generated_word_text.dart';
import 'package:myapp/constants/user_favorites.dart';
import 'package:myapp/screens/generator_page.dart';
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
          home: GeneratorPage(),
        ),
      ),
    );

    expect(generatedWords.wordPairHistory, isEmpty);

    final firstWord = generatedWords.currentWordPair;

    await widgetTester.tap(find.byKey(const Key('nextWord')));
    await widgetTester.pumpAndSettle();

    final listViewFinder = find.byKey(const Key('wordsHistory'));
    expect(listViewFinder, findsOneWidget);

    expect(generatedWords.wordPairHistory, hasLength(1));

    expect(
      find.byWidgetPredicate(
        (widget) => widget is GeneratedWordText && widget.wordPair == firstWord,
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is BigCard && widget.pair != firstWord,
      ),
      findsOneWidget,
    );

    await widgetTester.tap(find.byKey(const Key('toggleFavorite')));
    await widgetTester.pumpAndSettle();

    expect(generatedWords.favorites, contains(generatedWords.currentWordPair));
  });
}

final mockPreferences = <String, List<String>>{
  userFavoritesKey: [WordPair.random().asSnakeCase],
};
