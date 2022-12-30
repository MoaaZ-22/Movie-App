import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/useCase/base_usecase.dart';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/domain/useCases/get_popular_movies_usecase.dart';
import 'package:movie_app/movies/domain/useCases/get_top_rated_usecase.dart';
import 'package:movie_app/movies/presentation/controller/movies_event.dart';
import 'package:movie_app/movies/presentation/controller/movies_state.dart';
import '../../domain/useCases/get_now_playing_usecase.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MoviesBloc(this.getNowPlayingUseCase, this.getPopularMoviesUseCase,
      this.getTopRatedMoviesUseCase)
      : super(const MoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getNowPlayingUseCase(const NoParameters());
    result.fold((l) {
      emit(state.copyWith(
          nowPlayingState: RequestState.error, nowPlayingMessage: l.message));
    },
        (r) => emit(state.copyWith(
            nowPlayingState: RequestState.loaded, nowPlayingMovies: r)));
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(const NoParameters());
    result.fold((l) {
      emit(state.copyWith(
          popularState: RequestState.error, popularMessage: l.message));
    },
        (r) => emit(state.copyWith(
            popularState: RequestState.loaded, popularMovies: r)));
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMoviesUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            topRatedState: RequestState.error, topRatedMessage: l.message)),
        (r) => emit(state.copyWith(
            topRatedState: RequestState.loaded, topRatedMovies: r)));
  }
}
