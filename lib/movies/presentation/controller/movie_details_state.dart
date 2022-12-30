part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState(
      {this.requestState = RequestState.loading,
      this.movieDetail,
      this.message = '',
      this.castRequestState = RequestState.loading,
      this.movieCast,
      this.castMessage = ''});

  final RequestState requestState;
  final MovieDetail? movieDetail;
  final String message;
  final RequestState castRequestState;
  final List<MovieCast>? movieCast;
  final String castMessage;

  MovieDetailsState copyWith(
      {RequestState? requestState,
      MovieDetail? movieDetail,
      String? message,
      RequestState? castRequestState,
      List<MovieCast>? movieCast,
      String? castMessage}) {
    return MovieDetailsState(
        requestState: requestState ?? this.requestState,
        movieDetail: movieDetail ?? this.movieDetail,
        message: message ?? this.message,
        castRequestState: castRequestState ?? this.castRequestState,
        movieCast: movieCast ?? this.movieCast,
        castMessage: castMessage ?? this.castMessage);
  }

  @override
  List<Object?> get props => [
        requestState,
        movieDetail,
        message,
        castRequestState,
        movieCast,
        castMessage,
      ];
}
