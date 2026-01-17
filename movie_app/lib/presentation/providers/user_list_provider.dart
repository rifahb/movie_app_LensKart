import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import '../../data/services/storage_service.dart';

class UserListProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  List<Movie> _favorites = [];
  List<Movie> _watchlist = [];

  List<Movie> get favorites => _favorites;
  List<Movie> get watchlist => _watchlist;

  Future<void> loadLists() async {
    _favorites = await _storageService.getMovies(StorageService.keyFavorites);
    _watchlist = await _storageService.getMovies(StorageService.keyWatchlist);
    notifyListeners();
  }

  Future<void> toggleFavorite(Movie movie) async {
    if (await _storageService.isMovieInList(StorageService.keyFavorites, movie.id)) {
      await _storageService.removeMovie(StorageService.keyFavorites, movie.id);
    } else {
      await _storageService.saveMovie(StorageService.keyFavorites, movie);
    }
    await loadLists();
  }

  Future<void> toggleWatchlist(Movie movie) async {
    if (await _storageService.isMovieInList(StorageService.keyWatchlist, movie.id)) {
      await _storageService.removeMovie(StorageService.keyWatchlist, movie.id);
    } else {
      await _storageService.saveMovie(StorageService.keyWatchlist, movie);
    }
    await loadLists();
  }

  bool isFavorite(int movieId) {
    return _favorites.any((movie) => movie.id == movieId);
  }

  bool isWatchlisted(int movieId) {
    return _watchlist.any((movie) => movie.id == movieId);
  }
}
