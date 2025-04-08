import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/api_keys.dart';
import '../models/movie.dart';

class GeminiService {
  final String _apiKey = ApiKeys.geminiKey;
  final String _apiUrl = ApiKeys.geminiApiUrl;
  final http.Client _client = http.Client();
  
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: ApiKeys.geminiApiKey,
  );
  
  // Generate poetic movie summary
  Future<String> generatePoeticSummary(Movie movie) async {
    final prompt = '''
    Create a poetic, atmospheric summary of the movie "${movie.title}" (${movie.year}).
    Make it dreamy, evocative, and emotional - around 3-4 sentences.
    Use imagery and metaphors to capture the essence of the film.
    
    Details about the movie:
    - Synopsis: ${movie.overview}
    - Genre: ${movie.genreIds.map((id) => id).join(', ')}
    - Rating: ${movie.rating}/10
    ''';
    
    return await _generateContent(prompt);
  }
  
  // Generate movie insights
  Future<String> generateMovieInsights(Movie movie) async {
    final prompt = '''
    Provide 3 fascinating insights or fun facts about the movie "${movie.title}" (${movie.year}).
    Make them thought-provoking, interesting, and not obvious from watching the trailer.
    Format them as bullet points.
    
    Details about the movie:
    - Synopsis: ${movie.overview}
    - Genre: ${movie.genreIds.map((id) => id).join(', ')}
    ''';
    
    return await _generateContent(prompt);
  }
  
  // Generate movie recommendations based on mood
  Future<String> generateMoodBasedRecommendations(String mood, Movie movie) async {
    final prompt = '''
    Recommend 5 movies similar to "${movie.title}" (${movie.year}) that match the mood: $mood.
    For each recommendation, provide the title, year, and a brief one-sentence reason why it fits.
    Format as a list with film name and year in bold.
    
    Details about the reference movie:
    - Synopsis: ${movie.overview}
    - Genre: ${movie.genreIds.map((id) => id).join(', ')}
    - Mood: $mood
    ''';
    
    return await _generateContent(prompt);
  }
  
  // Answer user questions about a movie
  Future<String> answerMovieQuestion(String question, Movie movie) async {
    final prompt = '''
    Answer the following question about the movie "${movie.title}" (${movie.year}):
    
    Question: $question
    
    Details about the movie:
    - Synopsis: ${movie.overview}
    - Genre: ${movie.genreIds.map((id) => id).join(', ')}
    
    Provide a concise, informative answer. If you don't have specific information to answer the question accurately, acknowledge the limitations and offer related insights you can provide.
    ''';
    
    return await _generateContent(prompt);
  }
  
  // Generate character analysis
  Future<String> generateCharacterAnalysis(String character, Movie movie) async {
    final prompt = '''
    Provide a brief character analysis of "$character" from the movie "${movie.title}" (${movie.year}).
    Discuss their motivations, arc, and significance to the story in about 3-4 sentences.
    
    Details about the movie:
    - Synopsis: ${movie.overview}
    ''';
    
    return await _generateContent(prompt);
  }
  
  // Generate theme analysis
  Future<String> generateThemeAnalysis(Movie movie) async {
    final prompt = '''
    Analyze the key themes in the movie "${movie.title}" (${movie.year}).
    Identify 2-3 main themes and briefly explain how they're explored in the film.
    
    Details about the movie:
    - Synopsis: ${movie.overview}
    - Genre: ${movie.genreIds.map((id) => id).join(', ')}
    ''';
    
    return await _generateContent(prompt);
  }
  
  // Helper method to make API call to Gemini
  Future<String> _generateContent(String prompt) async {
    try {
      final uri = Uri.parse('$_apiUrl?key=$_apiKey');
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'] ?? 
               'Unable to generate content.';
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return 'An error occurred while generating content.';
      }
    } catch (e) {
      print('Exception: $e');
      return 'An error occurred while generating content.';
    }
  }

  Future<String> getMovieAnalysis(Movie movie) async {
    final prompt = '''
      Analyze the movie "${movie.title}" (${movie.year}) and provide a poetic, insightful analysis.
      Consider its themes, cinematography, and emotional impact.
      Write in a dreamy, ethereal tone that matches the movie's atmosphere.
      Keep it concise but meaningful.
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No analysis available';
  }

  Future<String> getSimilarMoviesByMood(Movie movie, String mood) async {
    final prompt = '''
      Based on the movie "${movie.title}" and the mood "$mood",
      suggest 5 similar movies that capture the same emotional essence.
      For each movie, provide a brief explanation of why it matches the mood.
      Write in a poetic, dreamy tone.
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No suggestions available';
  }

  Future<String> getFunFacts(Movie movie) async {
    final prompt = '''
      Share 3 interesting and lesser-known facts about the movie "${movie.title}".
      Make them fascinating and unexpected.
      Write in an engaging, storytelling tone.
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No fun facts available';
  }

  Future<String> getCharacterInsights(Movie movie) async {
    final prompt = '''
      Analyze the main characters in "${movie.title}" and provide deep insights
      about their motivations, relationships, and character arcs.
      Write in a thoughtful, psychological tone.
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No character insights available';
  }

  Future<String> chatAboutMovie(Movie movie, String userQuestion) async {
    final prompt = '''
      You are a knowledgeable movie expert discussing "${movie.title}".
      The user asked: "$userQuestion"
      Provide a thoughtful, detailed response that shows deep understanding
      of the movie and its themes. Write in a conversational yet insightful tone.
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'I apologize, but I cannot answer that question at this time.';
  }
}
