import 'dart:collection';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

final class GeneratedWords extends ChangeNotifier {
  WordPair currentWordPair = WordPair.random();

  final _favorites = <WordPair>{};

  UnmodifiableSetView<WordPair> get favorites =>
      UnmodifiableSetView(_favorites);

  final List<WordPair> _generatedWordsHistory = [];

  UnmodifiableListView<WordPair> get wordPairHistory =>
      UnmodifiableListView(_generatedWordsHistory);

  void nextWord() {
    _generatedWordsHistory.add(currentWordPair);
    currentWordPair = WordPair.random();
    notifyListeners();
  }

  void toggleFavorites(WordPair value) {
    if (_favorites.contains(value)) {
      _favorites.remove(value);
    } else {
      _favorites.add(value);
    }
    notifyListeners();
  }

  void deleteFavorite(WordPair value) {
    _favorites.remove(value);
    notifyListeners();
  }
}
