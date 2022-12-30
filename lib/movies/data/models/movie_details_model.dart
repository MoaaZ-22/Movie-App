import 'package:movie_app/movies/data/models/genres_model.dart';
import 'package:movie_app/movies/domain/entities/movie_detail.dart';

class MovieDetailsModel extends MovieDetail {
  const MovieDetailsModel(
      {required super.id,
      required super.title,
      required super.backdropPath,
      required super.overview,
      required super.runtime,
      required super.voteAverage,
      required super.releaseDate,
      required super.genres});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json)
  {
      return MovieDetailsModel(
          id: json['id'],
          title: json['title'],
          backdropPath: json['backdrop_path'],
          overview: json['overview'],
          runtime: json['runtime'],
          voteAverage: json['vote_average'].toDouble(),
          releaseDate: json['release_date'],
          genres: List<GenresModel>.from(json['genres'].map((x) => GenresModel.fromJson(x)))
      );
  }
}
