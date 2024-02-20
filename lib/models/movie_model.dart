// ignore_for_file: non_constant_identifier_names

class MovieModel {
  final String adult,
      backdrop_path,
      genre_ids,
      id,
      original_language,
      original_title,
      overview,
      popularity,
      poster_path,
      release_date,
      title,
      video,
      vote_average,
      vote_count;

  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdrop_path = json['backdrop_path'],
        genre_ids = json['genre_ids'],
        id = json['id'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        poster_path = json['poster_path'],
        release_date = json['release_date'],
        title = json['title'],
        video = json['video'],
        vote_average = json['vote_average'],
        vote_count = json['vote_count'];
}
