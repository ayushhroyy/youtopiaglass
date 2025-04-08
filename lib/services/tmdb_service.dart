import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_keys.dart';
import '../config/constants.dart';
import '../models/movie.dart';
import '../models/cast.dart';
import '../models/crew.dart';
import '../models/watch_provider.dart';

class TMDBService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p';

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular?api_key=${ApiKeys.tmdbApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId?api_key=${ApiKeys.tmdbApiKey}'),
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=${ApiKeys.tmdbApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['cast'] as List)
          .map((cast) => Cast.fromJson(cast))
          .toList();
    } else {
      throw Exception('Failed to load movie cast');
    }
  }

  Future<List<Crew>> getMovieCrew(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=${ApiKeys.tmdbApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['crew'] as List)
          .map((crew) => Crew.fromJson(crew))
          .toList();
    } else {
      throw Exception('Failed to load movie crew');
    }
  }

  Future<List<WatchProvider>> getWatchProviders(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/watch/providers?api_key=${ApiKeys.tmdbApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final providers = data['results']['US']?['flatrate'] ?? [];
      return (providers as List)
          .map((provider) => WatchProvider.fromJson(provider))
          .toList();
    } else {
      throw Exception('Failed to load watch providers');
    }
  }

  Future<String?> getYoutubeTrailerId(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=${ApiKeys.tmdbApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final videos = data['results'] as List;
      final trailer = videos.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );
      return trailer?['key'];
    } else {
      throw Exception('Failed to load movie videos');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search/movie?api_key=${ApiKeys.tmdbApiKey}&query=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/similar?api_key=${ApiKeys.tmdbApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load similar movies');
    }
  }
}