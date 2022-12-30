import 'package:dartz/dartz.dart';
import 'package:movie_app/core/useCase/base_usecase.dart';
import 'package:movie_app/error/failure.dart';
import 'package:movie_app/movies/domain/entities/genres.dart';
import 'package:movie_app/movies/domain/repository/base_movies_repository.dart';

class GetCategoriesStringUseCase extends BaseUseCase<List<Genres>, NoParameters>
{
  final BaseMoviesRepository baseMoviesRepository;

  GetCategoriesStringUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Genres>>> call(NoParameters parameters) async{
    return await baseMoviesRepository.getCategoriesString();
  }

}