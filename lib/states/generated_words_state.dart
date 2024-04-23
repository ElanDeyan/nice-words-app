import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

final class GeneratedWords extends ChangeNotifier {
  WordPair currentWordPair = WordPair.random();

  final favorites = <WordPair>{};

  final List<WordPair> _generatedWords = [];

  List<WordPair> get wordPairHistory => _generatedWords;

  void nextWord() {
    _generatedWords.add(currentWordPair);
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

  void deleteFavorite(WordPair value) {
    favorites.remove(value);
    notifyListeners();
  }
}
