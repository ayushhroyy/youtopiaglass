import '../config/constants.dart';
import 'cast.dart';
import 'crew.dart';
import 'watch_provider.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final List<int> genreIds;
  final List<String> genres;
  final int runtime;
  final String status;
  final String tagline;
  final List<WatchProvider> watchProviders;
  final List<Cast> cast;
  final List<Crew> crew;
  final String? youtubeTrailerId;

  // Constructor
  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.genreIds,
    required this.genres,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.watchProviders,
    required this.cast,
    required this.crew,
    this.youtubeTrailerId,
  });
  
  // Factory to create from API JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      genres: List<String>.from(json['genres']?.map((g) => g['name']) ?? []),
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      watchProviders: [],
      cast: [],
      crew: [],
    );
  }
  
  // Get year from release date
  String get year {
    return releaseDate.isNotEmpty ? releaseDate.split('-')[0] : '';
  }
  
  // Get rating as a string with one decimal place
  String get rating => voteAverage.toStringAsFixed(1);
  
  // Get runtime in hours and minutes format
  String get formattedRuntime {
    if (runtime == null) return '';
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }

  String get posterUrl => '${AppConstants.tmdbImageBaseUrl}/w500$posterPath';
  String get backdropUrl => '${AppConstants.tmdbImageBaseUrl}/original$backdropPath';
}
