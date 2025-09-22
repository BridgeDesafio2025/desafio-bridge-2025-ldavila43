
import 'dart:convert';

import 'package:movies__series_app/core/model/medium.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _favoritesKey = 'favorite_media_objects';

  Future<void> addFavorite(Medium medium) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];

    final String mediumJson = jsonEncode(medium.toJson());
    
    if(!favorites.any((favJson) => Medium.fromJson(jsonDecode(favJson)).id == medium.id)) {
      favorites.add(mediumJson);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  Future<void> removeFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];

    favorites.removeWhere((favJson) => Medium.fromJson(jsonDecode(favJson)).id == movieId);

    await prefs.setStringList(_favoritesKey, favorites);
    }

  Future<List<Medium>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

    return favoritesJson.map((favJson) => Medium.fromJson(jsonDecode(favJson))).toList();
  }

  Future<bool> isFavorite(int mediumId) async {
    final List<Medium> favorites = await getFavorites();
    return favorites.any((medium) => medium.id == mediumId);
  }
}