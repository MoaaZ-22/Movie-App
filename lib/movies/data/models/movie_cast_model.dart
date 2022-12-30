import 'package:movie_app/movies/domain/entities/movie_cast.dart';

class MovieCastModel extends MovieCast {
  const MovieCastModel(
      {required super.id,super.profilePath, required super.name});

  factory MovieCastModel.fromJson(Map<String, dynamic> json) {
    return MovieCastModel(
        id: json['id'], profilePath: json['profile_path'] ?? '/blKKsHlJIL9PmUQZB8f3YmMBW5Y.jpg', name: json['name']);
  }
}
