import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/genres.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/entities/movie_cast.dart';
import 'package:movie_app/movies/domain/entities/movie_detail.dart';
import 'package:movie_app/movies/domain/useCases/get_movie_cast_usecase.dart';
import 'package:movie_app/movies/domain/useCases/get_movie_details_usecase.dart';
import '../../../error/failure.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetail>> getMovieDetails(MovieDetailsParameters parameters);

  Future<Either<Failure, List<MovieCast>>> getMovieCast(MovieCastParameters parameters);

  Future<Either<Failure, List<Genres>>> getCategoriesString();
}
