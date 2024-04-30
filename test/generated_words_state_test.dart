import 'package:english_words/english_words.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/constants/user_favorites.dart';
import 'package:myapp/services/user_favorites_with_shared_preferences.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final mockFavorites = <String, List<String>>{
  userFavoritesKey: <String>[
    for (var i = 0; i < 10; i++) WordPair.random().asSnakeCase,
  ],
};

void main() async {
  setUp(() => SharedPreferences.setMockInitialValues(mockFavorites));

  SharedPreferences.setMockInitialValues(mockFavorites);

  var generatedWords = GeneratedWords(
    userFavoritesHandler: const UserFavoritesWithSharedPreferences(),
  );

  group('SharedPreferences', () {
    test('Has $userFavoritesKey key', () async {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList(userFavoritesKey);
      expect(favorites, isNotNull);
    });

    test('Has the initial data', () async {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList(userFavoritesKey);
      expect(favorites, isNotNull);
      expect(favorites, equals(mockFavorites[userFavoritesKey]));
    });
  });

  group('User favorites handler', () {
    var localFavorites = const UserFavoritesWithSharedPreferences();
    setUp(() {
      localFavorites = const UserFavoritesWithSharedPreferences();
    });
    tearDown(() => localFavorites = const UserFavoritesWithSharedPreferences());

    test('Getter', () async {
      expect(
        await localFavorites.userFavorites,
        mockFavorites[userFavoritesKey],
      );
    });

    test('Setter', () async {
      final wordsToAssign = [
        for (var i = 0; i < 10; i++) WordPair.random().asSnakeCase,
      ];

      expect(await localFavorites.userFavorites, isNot(wordsToAssign));

      await localFavorites.setUserFavorites(wordsToAssign);

      expect(await localFavorites.userFavorites, equals(wordsToAssign));

      await localFavorites.setUserFavorites(<String>[]);

      expect(await localFavorites.userFavorites, isEmpty);
    });

    test('Adding', () async {
      final wordPair = WordPair.random();

      await localFavorites.addFavorite(wordPair);

      expect(
        await localFavorites.userFavorites,
        containsOnce(wordPair.asSnakeCase),
      );

      expect(
        await localFavorites.userFavorites,
        hasLength(mockFavorites[userFavoritesKey]!.length + 1),
      );
    });

    test('Deleting favorite', () async {
      final sample = mockFavorites[userFavoritesKey]!.first;
      expect(await localFavorites.userFavorites, containsOnce(sample));

      final [sampleFirstWord, sampleSecondWord] = sample.split('_');

      await localFavorites
          .removeFavorite(WordPair(sampleFirstWord, sampleSecondWord));

      final userFavorites = await localFavorites.userFavorites;

      expect(userFavorites.contains(sample), isFalse);
    });

    test('Clear', () async {
      expect(
        await localFavorites.userFavorites,
        equals(mockFavorites[userFavoritesKey]),
      );

      await localFavorites.clearFavorites();

      expect(await localFavorites.userFavorites, isEmpty);
    });
  });

  group('Generated words', () {
    SharedPreferences.setMockInitialValues(mockFavorites);
    generatedWords = GeneratedWords(
      userFavoritesHandler: const UserFavoritesWithSharedPreferences(),
    );
    test('load with initial data', () async {
      expect(generatedWords.favorites, hasLength(10));
    });

    test('start with wordpair', () {
      expect(generatedWords.currentWordPair, isA<WordPair>());
    });

    test('first wordpair is not in history', () {
      final currentWordPair = generatedWords.currentWordPair;
      expect(
        generatedWords.wordPairHistory.contains(currentWordPair),
        isFalse,
      );
    });

    test('next adds to history', () {
      final firstWord = generatedWords.currentWordPair;
      generatedWords.nextWord();
      expect(generatedWords.wordPairHistory, contains(firstWord));
    });

    test('current is different than previous', () {
      final firstWord = generatedWords.currentWordPair;
      generatedWords.nextWord();
      expect(firstWord, isNot(generatedWords.currentWordPair));

      expect(generatedWords.wordPairHistory, containsOnce(firstWord));
    });

    test('toggle favorite', () {
      final firstWord = generatedWords.currentWordPair;
      generatedWords.nextWord();
      expect(generatedWords.favorites.contains(firstWord), isFalse);

      generatedWords.toggleFavorites(firstWord);
      expect(generatedWords.favorites, contains(firstWord));

      final currentWordPair = generatedWords.currentWordPair;

      generatedWords.toggleFavorites(currentWordPair);

      expect(
        generatedWords.favorites,
        contains(currentWordPair),
      );

      generatedWords.toggleFavorites(currentWordPair);

      expect(generatedWords.favorites.contains(currentWordPair), isFalse);
    });

    test('delete favorite', () {
      final firstWord = generatedWords.currentWordPair;

      generatedWords.toggleFavorites(firstWord);

      expect(generatedWords.favorites, containsOnce(firstWord));

      generatedWords.deleteFavorite(firstWord);

      expect(generatedWords.favorites.contains(firstWord), isFalse);

      generatedWords.nextWord();

      expect(
        generatedWords.wordPairHistory,
        containsOnce(firstWord),
        reason: "Remove from favorites doesn't remove from history",
      );

      // another time
      final anotherWord = generatedWords.currentWordPair;

      expect(anotherWord, isNot(firstWord));

      generatedWords.toggleFavorites(anotherWord);

      expect(generatedWords.favorites, containsOnce(anotherWord));

      generatedWords.deleteFavorite(anotherWord);

      expect(generatedWords.favorites.contains(anotherWord), isFalse);
    });
  });
}
