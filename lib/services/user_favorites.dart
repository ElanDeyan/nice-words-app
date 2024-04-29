import 'package:english_words/english_words.dart';

abstract interface class UserFavorites {
  Future<List<String>> get userFavorites;

  Future<void> addFavorite(WordPair wordPair);

  Future<void> clearFavorites();

  Future<void> removeFavorite(WordPair wordPair);

  Future<void> setUserFavorites(List<String> newFavorites);
}
