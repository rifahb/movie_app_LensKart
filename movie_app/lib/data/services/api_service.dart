import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../models/movie_model.dart';

class ApiService {
  Future<List<Movie>> getTrendingMovies() async {
    final url = Uri.parse('${AppConstants.baseUrl}/trending/movie/week?api_key=${AppConstants.apiKey}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('${AppConstants.baseUrl}/search/movie?api_key=${AppConstants.apiKey}&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
