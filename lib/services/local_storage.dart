import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class LocalStorage {
  // Keys
  static const String favoriteMoviesKey = 'favorite_movies';
  static const String watchlistMoviesKey = 'watchlist_movies';
  static const String themePreferenceKey = 'theme_preference';
  static const String soundEnabledKey = 'sound_enabled';
  static const String lastViewedMoviesKey = 'last_viewed_movies';
  static const String _themeModeKey = 'theme_mode';
  static const String _recentSearchesKey = 'recent_searches';
  static const String _backgroundMusicKey = 'background_music';
  
  // Save favorite movie
  static Future<bool> saveFavoriteMovie(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteMovies();
    
    // Check if movie already exists in favorites
    if (favorites.any((m) => m.id == movie.id)) {
      return true; // Already saved
    }
    
    // Add to favorites
    favorites.add(movie);
    
    // Convert to JSON list
    final jsonList = favorites.map((movie) => json.encode({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'voteAverage': movie.voteAverage,
      'releaseDate': movie.releaseDate,
      'genreIds': movie.genreIds,
    })).toList();
    
    // Save to shared preferences
    return await prefs.setStringList(favoriteMoviesKey, jsonList);
  }
  
  // Remove favorite movie
  static Future<bool> removeFavoriteMovie(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteMovies();
    
    // Remove movie
    favorites.removeWhere((movie) => movie.id == movieId);
    
    // Convert to JSON list
    final jsonList = favorites.map((movie) => json.encode({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'voteAverage': movie.voteAverage,
      'releaseDate': movie.releaseDate,
      'genreIds': movie.genreIds,
    })).toList();
    
    // Save to shared preferences
    return await prefs.setStringList(favoriteMoviesKey, jsonList);
  }
  
  // Get favorite movies
  static Future<List<Movie>> getFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(favoriteMoviesKey) ?? [];
    
    // Convert JSON to Movie objects
    return jsonList.map((jsonString) {
      final map = json.decode(jsonString);
      return Movie(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        voteAverage: map['voteAverage'],
        releaseDate: map['releaseDate'],
        genreIds: List<int>.from(map['genreIds']),
      );
    }).toList();
  }
  
  // Check if movie is favorite
  static Future<bool> isFavoriteMovie(int movieId) async {
    final favorites = await getFavoriteMovies();
    return favorites.any((movie) => movie.id == movieId);
  }
  
  // Similar functions for watchlist
  static Future<bool> saveWatchlistMovie(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final watchlist = await getWatchlistMovies();
    
    if (watchlist.any((m) => m.id == movie.id)) {
      return true;
    }
    
    watchlist.add(movie);
    
    final jsonList = watchlist.map((movie) => json.encode({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'voteAverage': movie.voteAverage,
      'releaseDate': movie.releaseDate,
      'genreIds': movie.genreIds,
    })).toList();
    
    return await prefs.setStringList(watchlistMoviesKey, jsonList);
  }
  
  static Future<bool> removeWatchlistMovie(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final watchlist = await getWatchlistMovies();
    
    watchlist.removeWhere((movie) => movie.id == movieId);
    
    final jsonList = watchlist.map((movie) => json.encode({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'voteAverage': movie.voteAverage,
      'releaseDate': movie.releaseDate,
      'genreIds': movie.genreIds,
    })).toList();
    
    return await prefs.setStringList(watchlistMoviesKey, jsonList);
  }
  
  static Future<List<Movie>> getWatchlistMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(watchlistMoviesKey) ?? [];
    
    return jsonList.map((jsonString) {
      final map = json.decode(jsonString);
      return Movie(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        voteAverage: map['voteAverage'],
        releaseDate: map['releaseDate'],
        genreIds: List<int>.from(map['genreIds']),
      );
    }).toList();
  }
  
  static Future<bool> isWatchlistMovie(int movieId) async {
    final watchlist = await getWatchlistMovies();
    return watchlist.any((movie) => movie.id == movieId);
  }
  
  // Save theme preference
  static Future<bool> saveThemePreference(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(themePreferenceKey, theme);
  }
  
  // Get theme preference
  static Future<String> getThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themePreferenceKey) ?? 'dark'; // Default to dark
  }
  
  // Save sound enabled preference
  static Future<bool> saveSoundEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(soundEnabledKey, enabled);
  }
  
  // Get sound enabled preference
  static Future<bool> getSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(soundEnabledKey) ?? false; // Default to false
  }
  
  // Save recently viewed movie
  static Future<bool> saveRecentlyViewedMovie(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final recentMovies = await getRecentlyViewedMovies();
    
    // Remove if already exists (to reorder)
    recentMovies.removeWhere((m) => m.id == movie.id);
    
    // Add to the beginning
    recentMovies.insert(0, movie);
    
    // Keep only the last 10
    if (recentMovies.length > 10) {
      recentMovies.removeLast();
    }
    
    // Convert to JSON list
    final jsonList = recentMovies.map((movie) => json.encode({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'voteAverage': movie.voteAverage,
      'releaseDate': movie.releaseDate,
      'genreIds': movie.genreIds,
    })).toList();
    
    // Save to shared preferences
    return await prefs.setStringList(lastViewedMoviesKey, jsonList);
  }
  
  // Get recently viewed movies
  static Future<List<Movie>> getRecentlyViewedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(lastViewedMoviesKey) ?? [];
    
    // Convert JSON to Movie objects
    return jsonList.map((jsonString) {
      final map = json.decode(jsonString);
      return Movie(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        voteAverage: map['voteAverage'],
        releaseDate: map['releaseDate'],
        genreIds: List<int>.from(map['genreIds']),
      );
    }).toList();
  }
  
  // Clear all data
  static Future<bool> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  static Future<void> setThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeModeKey, isDark);
  }

  static Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeModeKey) ?? true; // Default to dark theme
  }

  static Future<void> addFavoriteMovie(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(favoriteMoviesKey) ?? [];
    if (!favorites.contains(movieId.toString())) {
      favorites.add(movieId.toString());
      await prefs.setStringList(favoriteMoviesKey, favorites);
    }
  }

  static Future<void> removeFavoriteMovie(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(favoriteMoviesKey) ?? [];
    favorites.remove(movieId.toString());
    await prefs.setStringList(favoriteMoviesKey, favorites);
  }

  static Future<List<int>> getFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(favoriteMoviesKey) ?? [];
    return favorites.map((id) => int.parse(id)).toList();
  }

  static Future<bool> isMovieFavorite(int movieId) async {
    final favorites = await getFavoriteMovies();
    return favorites.contains(movieId);
  }

  static Future<void> addRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList(_recentSearchesKey) ?? [];
    searches.remove(query); // Remove if exists to avoid duplicates
    searches.insert(0, query); // Add to beginning
    if (searches.length > 10) {
      searches.removeLast(); // Keep only last 10 searches
    }
    await prefs.setStringList(_recentSearchesKey, searches);
  }

  static Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  static Future<void> setBackgroundMusicEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_backgroundMusicKey, enabled);
  }

  static Future<bool> isBackgroundMusicEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_backgroundMusicKey) ?? true; // Default to enabled
  }
}
