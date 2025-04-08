import '../config/constants.dart';

class Crew {
  final int id;
  final String name;
  final String job;
  final String department;
  final String profilePath;

  Crew({
    required this.id,
    required this.name,
    required this.job,
    required this.department,
    required this.profilePath,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      job: json['job'] ?? '',
      department: json['department'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }

  String get profileUrl => '${AppConstants.tmdbImageBaseUrl}/w185$profilePath';
} 