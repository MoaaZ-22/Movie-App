import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/core/network/error_message_model.dart';
import 'package:movie_app/core/useCase/base_usecase.dart';
import 'package:movie_app/error/exceptions.dart';
import 'package:movie_app/movies/data/models/genres_model.dart';
import 'package:movie_app/movies/data/models/movie_cast_model.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/movie_model.dart';
import 'package:movie_app/movies/domain/useCases/get_movie_details_usecase.dart';
import '../../domain/useCases/get_movie_cast_usecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameters parameters);

  Future<List<MovieCastModel>> getMovieCast(MovieCastParameters parameters);

  Future<List<GenresModel>> getCategoriesString();
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await Dio().get(ApiConstants.nowPlayingMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstants.upcomingMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(ApiConstants.topRatedMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameters parameters) async{
    final response = await Dio().get(ApiConstants.movieDetailsPath(parameters.movieId));

    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieCastModel>> getMovieCast(MovieCastParameters parameters) async{
    final response = await Dio().get(ApiConstants.movieCastPath(parameters.movieId));

    if (response.statusCode == 200) {
      return List<MovieCastModel>.from((response.data['cast'] as List)
          .map((e) => MovieCastModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<GenresModel>> getCategoriesString() async{
    final response = await Dio().get(ApiConstants.categoriesStringPath);

    if (response.statusCode == 200) {
      return List<GenresModel>.from((response.data['genres'] as List)
          .map((e) => MovieCastModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
