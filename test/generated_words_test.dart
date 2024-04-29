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
  final GeneratedWords generatedWords = GeneratedWords(
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
    test('load with initial data', () async {
      expect(generatedWords.favorites, hasLength(10));
    });
  });
}
