import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

final class MyAppGlobalState extends ChangeNotifier {
  WordPair currentWordPair = WordPair.random();

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
