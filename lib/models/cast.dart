import '../config/constants.dart';

class Cast {
  final int id;
  final String name;
  final String character;
  final String profilePath;
  final int order;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'] ?? '',
      order: json['order'] ?? 0,
    );
  }

  String get profileUrl => '${AppConstants.tmdbImageBaseUrl}/w185$profilePath';
}

class Crew {
  final int id;
  final String name;
  final String? profilePath;
  final String job;
  final String department;
  
  Crew({
    required this.id,
    required this.name,
    this.profilePath,
    required this.job,
    required this.department,
  });
  
  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      job: json['job'] ?? '',
      department: json['department'] ?? '',
    );
  }
}

class Credits {
  final List<Cast> cast;
  final List<Crew> crew;
  
  Credits({
    required this.cast,
    required this.crew,
  });
  
  factory Credits.fromJson(Map<String, dynamic> json) {
    return Credits(
      cast: (json['cast'] as List)
          .map((castJson) => Cast.fromJson(castJson))
          .toList(),
      crew: (json['crew'] as List)
          .map((crewJson) => Crew.fromJson(crewJson))
          .toList(),
    );
  }
  
  // Helper method to get director
  List<Crew> getDirectors() {
    return crew.where((crew) => crew.job == 'Director').toList();
  }
  
  // Helper method to get writers
  List<Crew> getWriters() {
    return crew.where((crew) => 
      crew.department == 'Writing' || 
      crew.job == 'Screenplay' || 
      crew.job == 'Writer'
    ).toList();
  }
}
