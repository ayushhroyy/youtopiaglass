class Genre {
  final int id;
  final String name;
  
  Genre({
    required this.id,
    required this.name,
  });
  
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
  
  // Static map of common genre IDs to names
  static const Map<int, String> genreMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };
  
  // Get genre name by id
  static String getGenreName(int id) {
    return genreMap[id] ?? 'Unknown';
  }
  
  // Get a list of genre names from a list of ids
  static List<String> getGenreNames(List<int> ids) {
    return ids.map((id) => getGenreName(id)).toList();
  }
}
