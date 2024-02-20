import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moonflix/models/movie_detail_model.dart';

import 'package:moonflix/models/movie_simple_model.dart';

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  static Future<List<MovieSimpleModel>> getPopularMovies() async {
    List<MovieSimpleModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/popular');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(res.body)['results'];
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
      final List<dynamic> movies = jsonDecode(res.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieSimpleModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieSimpleModel>> getCommingSoonMovies() async {
    List<MovieSimpleModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/comming-soon');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(res.body);
      for (var movie in movies) {
        movieInstances.add(MovieSimpleModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final movie = jsonDecode(res.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
