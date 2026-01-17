import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

class StorageService {
  static const String keyFavorites = 'favorites';
  static const String keyWatchlist = 'watchlist';

  Future<void> saveMovie(String key, Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(key) ?? [];
    
    // Check if already exists to avoid duplicates
    if (!list.any((item) => Movie.fromJson(json.decode(item)).id == movie.id)) {
      list.add(json.encode(movie.toJson()));
      await prefs.setStringList(key, list);
    }
  }

  Future<void> removeMovie(String key, int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(key) ?? [];
    
    list.removeWhere((item) {
      final movie = Movie.fromJson(json.decode(item));
      return movie.id == movieId;
    });
    
    await prefs.setStringList(key, list);
  }

  Future<List<Movie>> getMovies(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(key) ?? [];
    
    return list.map((item) => Movie.fromJson(json.decode(item))).toList();
  }

  Future<bool> isMovieInList(String key, int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(key) ?? [];
    
    return list.any((item) {
      final movie = Movie.fromJson(json.decode(item));
      return movie.id == movieId;
    });
  }
}
