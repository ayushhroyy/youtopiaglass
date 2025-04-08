class AppConstants {
  // App name
  static const String appName = 'Youtopia';
  static const String appDescription = 'Your portal to cinematic dreams';
  
  // Image quality options for TMDB
  static const String posterSizeSmall = 'w185';
  static const String posterSizeMedium = 'w342';
  static const String posterSizeLarge = 'w500';
  static const String backdropSizeSmall = 'w300';
  static const String backdropSizeLarge = 'w1280';
  static const String profileSizeSmall = 'w45';
  static const String profileSizeMedium = 'w185';
  
  // Animation durations
  static const Duration quickAnimation = Duration(milliseconds: 300);
  static const Duration normalAnimation = Duration(milliseconds: 500);
  static const Duration slowAnimation = Duration(milliseconds: 800);
  
  // Movie moods
  static const List<Map<String, dynamic>> movieMoods = [
    {
      'name': 'Heartbreaking',
      'color': 0xFFFF6B6B,
      'icon': 'assets/icons/heartbreak.png',
      'genres': [18], // Drama
      'keywords': ['tragic', 'sad', 'emotional']
    },
    {
      'name': 'Inspiring',
      'color': 0xFFFFD93D,
      'icon': 'assets/icons/inspire.png',
      'genres': [18, 36], // Drama, History
      'keywords': ['inspiring', 'uplifting', 'motivational']
    },
    {
      'name': 'Thrilling',
      'color': 0xFF6BCB77,
      'icon': 'assets/icons/thrill.png',
      'genres': [28, 53], // Action, Thriller
      'keywords': ['suspense', 'exciting', 'adventure']
    },
    {
      'name': 'Feel-Good',
      'color': 0xFF4D96FF,
      'icon': 'assets/icons/feelgood.png',
      'genres': [35, 10751], // Comedy, Family
      'keywords': ['uplifting', 'heartwarming', 'comedy']
    },
    {
      'name': 'Dark',
      'color': 0xFF6C7A89,
      'icon': 'assets/icons/dark.png',
      'genres': [27, 80], // Horror, Crime
      'keywords': ['disturbing', 'gritty', 'suspense']
    },
    {
      'name': 'Classic',
      'color': 0xFFBA90C6,
      'icon': 'assets/icons/classic.png',
      'genres': [36], // History
      'keywords': ['classic', 'masterpiece', 'timeless']
    },
  ];
  
  // Default blur values
  static const double smallBlur = 5.0;
  static const double mediumBlur = 15.0;
  static const double largeBlur = 30.0;
  
  // Glass effect values
  static const double glassOpacity = 0.15;
  static const double glassBorderRadius = 16.0;

  static const List<String> moods = [
    'Heartbreaking',
    'Inspiring',
    'Thrilling',
    'Feel-Good',
    'Dark',
    'Classic',
    'Romantic',
    'Adventure',
    'Mystery',
    'Sci-Fi',
  ];

  static const Map<String, String> moodIcons = {
    'Heartbreaking': '💔',
    'Inspiring': '✨',
    'Thrilling': '⚡',
    'Feel-Good': '😊',
    'Dark': '🌑',
    'Classic': '🎭',
    'Romantic': '💕',
    'Adventure': '🗺️',
    'Mystery': '🔍',
    'Sci-Fi': '🚀',
  };

  static const int maxSimilarMovies = 5;
  static const int maxCastMembers = 10;
  static const int maxReviews = 3;
  
  static const Duration animationDuration = Duration(milliseconds: 500);
  static const Duration hoverAnimationDuration = Duration(milliseconds: 200);
  
  static const double cardAspectRatio = 0.7;
  static const double posterAspectRatio = 0.67;
  
  static const String youtubeBaseUrl = 'https://www.youtube.com/watch?v=';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p';
  
  static const List<String> imageSizes = [
    'w92',
    'w154',
    'w185',
    'w342',
    'w500',
    'w780',
    'original'
  ];
}
