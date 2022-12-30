import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/useCase/base_usecase.dart';
import 'package:movie_app/error/failure.dart';
import 'package:movie_app/movies/domain/entities/movie_cast.dart';
import 'package:movie_app/movies/domain/repository/base_movies_repository.dart';

class GetMovieCastUseCase extends BaseUseCase<List<MovieCast>, MovieCastParameters>{
 final BaseMoviesRepository baseMoviesRepository;

 GetMovieCastUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<MovieCast>>> call(MovieCastParameters parameters) async{
    return await baseMoviesRepository.getMovieCast(parameters);
  }
}

class MovieCastParameters extends Equatable {
  final int movieId;

  const MovieCastParameters(this.movieId);

  @override
  List<Object> get props => [movieId];
}