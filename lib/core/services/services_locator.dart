import 'package:get_it/get_it.dart';
import 'package:movie_app/movies/data/dataResource/movie_remote_data_source.dart';
import 'package:movie_app/movies/data/repository/movies_repository.dart';
import 'package:movie_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movie_app/movies/domain/useCases/get_movie_cast_usecase.dart';
import 'package:movie_app/movies/domain/useCases/get_movie_details_usecase.dart';
import 'package:movie_app/movies/domain/useCases/get_now_playing_usecase.dart';
import 'package:movie_app/movies/domain/useCases/get_popular_movies_usecase.dart';
import 'package:movie_app/movies/domain/useCases/get_top_rated_usecase.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  init() {
    /// Movies Bloc With Singleton
    sl.registerFactory(() => MoviesBloc(sl(), sl(), sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl(), sl()));

    sl.registerLazySingleton(() => GetNowPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieCastUseCase(sl()));

    /// Singleton For MoviesRepository
    sl.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(baseMovieRemoteDataSource: sl()));

    /// Singleton For MovieRemoteDataSource
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());
  }
}
