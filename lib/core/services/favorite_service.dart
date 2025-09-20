
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _favoritesKey = 'favorite_movie_ids';

  Future<void> addFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];

    if(!favorites.contains(movieId.toString())) {
      favorites.add(movieId.toString());
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  Future<void> removeFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];

    favorites.remove(movieId.toString());
    await prefs.setStringList(_favoritesKey, favorites);
    }

  Future<List<int>> getFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];

    return favorites.map(int.parse).toList();
  }

  Future<bool> isFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];

    return favorites.contains(movieId.toString());
  }
}