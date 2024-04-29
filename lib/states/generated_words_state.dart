import 'dart:collection';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/user_favorites.dart';

final class GeneratedWords extends ChangeNotifier {
  GeneratedWords({required UserFavorites userFavoritesHandler})
      : _userFavoritesHandler = userFavoritesHandler {
    Future.microtask(() async => await loadLocalUserFavorites());
  }

  final UserFavorites _userFavoritesHandler;

  Future<void> loadLocalUserFavorites() async {
    final localFavorites = await _userFavoritesHandler.userFavorites;

    _favorites = localFavorites.map((e) {
      final [first, second] = e.split('_');

      return WordPair(first, second);
    }).toSet();
  }

  WordPair currentWordPair = WordPair.random();

  Set<WordPair> _favorites = <WordPair>{};

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
      Future.microtask(
        () async => await _userFavoritesHandler.removeFavorite(value),
      );
    } else {
      _favorites.add(value);
      Future.microtask(
        () async => await _userFavoritesHandler.addFavorite(value),
      );
    }
    notifyListeners();
  }

  void deleteFavorite(WordPair value) {
    _favorites.remove(value);
    Future.microtask(
      () async => await _userFavoritesHandler.removeFavorite(value),
    );
    notifyListeners();
  }
}
