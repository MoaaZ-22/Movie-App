import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/domain/entities/movie_detail.dart';
import '../../../core/utils/enums.dart';
import '../../domain/entities/movie_cast.dart';
import '../../domain/useCases/get_movie_cast_usecase.dart';
import '../../domain/useCases/get_movie_details_usecase.dart';
part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetMovieCastUseCase getMovieCastUseCase;

  MovieDetailsBloc(this.getMovieDetailsUseCase, this.getMovieCastUseCase) : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieCastEvent>(_getMovieCast);
  }

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await getMovieDetailsUseCase(MovieDetailsParameters(event.id));

    result.fold(
        (l) => emit(state.copyWith(
            requestState: RequestState.error, message: l.message)),
        (r) => emit(
            state.copyWith(requestState: RequestState.loaded, movieDetail: r)));
  }

  FutureOr<void> _getMovieCast(GetMovieCastEvent event, Emitter<MovieDetailsState> emit) async{
    final result =
    await getMovieCastUseCase(MovieCastParameters(event.id));

    result.fold(
            (l) => emit(state.copyWith(
            castRequestState: RequestState.error, castMessage: l.message)),
            (r) => emit(
            state.copyWith(castRequestState: RequestState.loaded, movieCast: r)));
  }
}
