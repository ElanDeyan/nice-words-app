import 'package:english_words/english_words.dart';
import 'package:myapp/constants/user_favorites.dart';
import 'package:myapp/services/user_favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class UserFavoritesWithSharedPreferences implements UserFavorites {
  const UserFavoritesWithSharedPreferences();

  @override
  Future<void> addFavorite(WordPair wordPair) async {
    final userFavorites = await this.userFavorites;

    userFavorites.add(wordPair.asSnakeCase);

    await setUserFavorites(userFavorites);
  }

  @override
  Future<void> clearFavorites() async {
    await setUserFavorites(<String>[]);
  }

  @override
  Future<void> removeFavorite(WordPair wordPair) async {
    final userFavorites = await this.userFavorites;

    userFavorites.remove(wordPair.asSnakeCase);

    await setUserFavorites(userFavorites);
  }

  @override
  Future<List<String>> get userFavorites async {
    final prefs = await SharedPreferences.getInstance();
    final userFavorites = prefs.getStringList(userFavoritesKey) ?? <String>[];

    return userFavorites;
  }

  @override
  Future<void> setUserFavorites(List<String> newFavorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(userFavoritesKey, newFavorites);
  }
}
