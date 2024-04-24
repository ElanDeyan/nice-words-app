import 'dart:math' show Random;

import 'package:english_words/english_words.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/states/generated_words_state.dart';

void main() {
  late GeneratedWords generatedWords;
  setUp(() => generatedWords = GeneratedWords());

  tearDown(() => generatedWords = GeneratedWords());

  group('Start state', () {
    test(
      'with an randomWord without call next',
      () => expect(generatedWords.currentWordPair, isA<WordPair>()),
    );

    test(
      'with empty history',
      () => expect(generatedWords.wordPairHistory, equals(<WordPair>[])),
    );

    test(
      'with empty favorites set',
      () => expect(generatedWords.favorites, equals(<WordPair>{})),
    );
  });

  group('Generating words', () {
    setUp(() => generatedWords..nextWord());

    test('is adding', () {
      expect(generatedWords.wordPairHistory, hasLength(1));
      expect(
        generatedWords.wordPairHistory.single,
        isNot(generatedWords.currentWordPair),
      );
    });
    test('adding more than one time', () {
      final numberOfPairsToAdd = Random().nextInt(10);
      final numberOfItemsBeforeAdd = generatedWords
          .wordPairHistory.length; // should be 1 because of setup of this group

      for (var i = 0; i < numberOfPairsToAdd; i++) {
        generatedWords.nextWord();
      }

      expect(
        generatedWords.wordPairHistory,
        hasLength(numberOfItemsBeforeAdd + numberOfPairsToAdd),
      );
    });
  });

  group('Favorites', () {
    generatedWords = GeneratedWords();

    group('Toggling favorite', () {
      final numberOfPairToGenerate = Random().nextInt(10) + 1;
      for (var i = 0; i < numberOfPairToGenerate; i++) {
        generatedWords.nextWord();
      }

      final generatedWordsHistory = generatedWords.wordPairHistory;

      final randomIndex = Random().nextInt(generatedWordsHistory.length);

      final itemToUse = generatedWordsHistory[randomIndex];
      test('adding one favorite', () {
        expect(generatedWords.favorites, isEmpty);
        generatedWords.toggleFavorites(itemToUse);
        expect(generatedWords.favorites, hasLength(1));
        expect(
          generatedWords.favorites,
          contains(itemToUse),
        );
      });

      test('Removing favorite', () {
        expect(generatedWords.favorites, isEmpty);

        generatedWords
          ..toggleFavorites(itemToUse)
          ..toggleFavorites(itemToUse);

        expect(generatedWords.favorites, isEmpty);
      });
    });
  });

  group('Deleting favorite', () {
    generatedWords = GeneratedWords();
    final numberOfPairToGenerate = Random().nextInt(10) + 1;
    for (var i = 0; i < numberOfPairToGenerate; i++) {
      generatedWords.nextWord();
    }

    final generatedWordsHistory = generatedWords.wordPairHistory;

    final randomIndex = Random().nextInt(generatedWordsHistory.length);

    final itemToUse = generatedWordsHistory[randomIndex];

    test('deleting', () {
      generatedWords.toggleFavorites(itemToUse);
      expect(
        generatedWords.favorites,
        contains(itemToUse),
      );

      generatedWords.deleteFavorite(itemToUse);

      expect(
        generatedWords.favorites.contains(itemToUse),
        isFalse,
      );
    });
  });

  group('Is notifying', () {
    test('generating a word', () {
      var currentWordPair = generatedWords.currentWordPair;

      generatedWords.addListener(() {
        expect(currentWordPair, isNot(generatedWords.currentWordPair));
        currentWordPair = generatedWords.currentWordPair;
      });

      generatedWords.nextWord();
      expect(currentWordPair, generatedWords.currentWordPair);
    });

    test('toggling favorite', () {
      final wordPair = generatedWords.currentWordPair;
      var isFavorited = false;
      generatedWords.addListener(() {
        isFavorited = !isFavorited;
      });

      generatedWords.toggleFavorites(wordPair);
      expect(isFavorited, isTrue);
      generatedWords.toggleFavorites(wordPair);

      expect(isFavorited, isFalse);
    });
  });
}
