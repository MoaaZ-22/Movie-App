import 'package:dartz/dartz.dart';
import 'package:movie_app/core/useCase/base_usecase.dart';
import 'package:movie_app/movies/domain/repository/base_movies_repository.dart';
import '../../../error/failure.dart';
import '../entities/movie.dart';

class GetPopularMoviesUseCase extends BaseUseCase<List<Movie>, NoParameters>
{
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async{
    return await baseMoviesRepository.getPopularMovies();
  }


}