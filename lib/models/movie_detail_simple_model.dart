// ignore_for_file: non_constant_identifier_names

class MovieDetailSimpleModel {
  final int id;
  final String title, original_title;
  final double vote_average;
  final int runtime;
  final List<dynamic> genres;
  final String overview;
  final String poster_path;

  MovieDetailSimpleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        original_title = json['original_title'],
        vote_average = json['vote_average'],
        runtime = json['runtime'],
        genres = json['genres'],
        overview = json['overview'],
        poster_path = json['poster_path'];
}
