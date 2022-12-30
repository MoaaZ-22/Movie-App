import 'package:equatable/equatable.dart';

import 'genres.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final String backdropPath;
  final String overview;
  final int runtime;
  final double voteAverage;
  final String releaseDate;
  final List<Genres> genres;

  const MovieDetail(
      {required this.id,
      required this.title,
      required this.backdropPath,
      required this.overview,
      required this.runtime,
      required this.voteAverage,
      required this.releaseDate,
      required this.genres});

  @override
  List<Object> get props => [
        id,
        title,
        backdropPath,
        overview,
        runtime,
        voteAverage,
        releaseDate,
        genres
      ];
}
