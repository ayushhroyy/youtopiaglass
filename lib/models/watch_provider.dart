import '../config/constants.dart';

class WatchProvider {
  final int providerId;
  final String providerName;
  final String logoPath;
  final String? link;

  WatchProvider({
    required this.providerId,
    required this.providerName,
    required this.logoPath,
    this.link,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> json) {
    return WatchProvider(
      providerId: json['provider_id'] ?? 0,
      providerName: json['provider_name'] ?? '',
      logoPath: json['logo_path'] ?? '',
      link: json['link'],
    );
  }

  String get logoUrl => '${AppConstants.tmdbImageBaseUrl}/w92$logoPath';
}

class WatchProviders {
  final String link;
  final Map<String, List<WatchProvider>> providers;
  
  WatchProviders({
    required this.link,
    required this.providers,
  });
  
  factory WatchProviders.fromJson(Map<String, dynamic> json) {
    final results = json['results'];
    Map<String, List<WatchProvider>> providers = {};
    
    // Only process US results for simplicity
    if (results != null && results['US'] != null) {
      final usResults = results['US'];
      
      // Process different provider types (rent, buy, flatrate/streaming)
      providers = {
        'flatrate': _processProviderList(usResults['flatrate']),
        'rent': _processProviderList(usResults['rent']),
        'buy': _processProviderList(usResults['buy']),
      };
    }
    
    return WatchProviders(
      link: json['results']?['US']?['link'] ?? '',
      providers: providers,
    );
  }
  
  static List<WatchProvider> _processProviderList(List? providerList) {
    if (providerList == null) return [];
    
    return providerList
        .map((provider) => WatchProvider.fromJson(provider))
        .toList();
  }
  
  // Get streaming providers only
  List<WatchProvider> get streamingProviders {
    return providers['flatrate'] ?? [];
  }
  
  // Get rental providers
  List<WatchProvider> get rentalProviders {
    return providers['rent'] ?? [];
  }
  
  // Get purchase providers
  List<WatchProvider> get purchaseProviders {
    return providers['buy'] ?? [];
  }
  
  // Check if there are any providers at all
  bool get hasProviders {
    return streamingProviders.isNotEmpty || 
           rentalProviders.isNotEmpty || 
           purchaseProviders.isNotEmpty;
  }
}
