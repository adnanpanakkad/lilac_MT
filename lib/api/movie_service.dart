import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lilac_movie_app/models/movie_model.dart';

class MovieService {
  static const String _apiKey = "df22cde6";

  Future<List<Movie>> fetchMovies(String query, {int page = 2}) async {
    final url = Uri.parse(
      "https://www.omdbapi.com/?apikey=$_apiKey&s=$query&page=$page",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('#####################${data}');

      if (data['Response'] == 'True') {
        final List movies = data['Search'];
        return movies.map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception(data['Error']); // e.g. Movie not found
      }
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
