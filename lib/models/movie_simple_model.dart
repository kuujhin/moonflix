// ignore_for_file: non_constant_identifier_names

class MovieSimpleModel {
  final int id;
  final String poster_path, title, backdrop_path;

  MovieSimpleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        poster_path = json['poster_path'],
        title = json['title'],
        backdrop_path = json['backdrop_path'];
}
