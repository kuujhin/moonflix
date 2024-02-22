import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moonflix/models/movie_simple_model.dart';
import 'package:moonflix/models/movie_detail_simple_model.dart';

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  static Future<List<MovieSimpleModel>> getPopularMovies() async {
    List<MovieSimpleModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/popular');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      // final List<dynamic> movies = jsonDecode(res.body)['results'];
      final List<dynamic> movies =
          jsonDecode(utf8.decode(res.bodyBytes))['results'];
      for (var movie in movies) {
        movieInstances.add(MovieSimpleModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieSimpleModel>> getNowPlayingMovies() async {
    List<MovieSimpleModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/now-playing');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<dynamic> movies =
          jsonDecode(utf8.decode(res.bodyBytes))['results'];
      for (var movie in movies) {
        movieInstances.add(MovieSimpleModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieSimpleModel>> getComingSoonMovies() async {
    List<MovieSimpleModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/coming-soon');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<dynamic> movies =
          jsonDecode(utf8.decode(res.bodyBytes))['results'];
      for (var movie in movies) {
        movieInstances.add(MovieSimpleModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailSimpleModel> getMovieById(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final movie = jsonDecode(utf8.decode(res.bodyBytes));
      return MovieDetailSimpleModel.fromJson(movie);
    }
    throw Error();
  }
}
