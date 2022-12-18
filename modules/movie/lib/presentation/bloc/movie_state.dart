part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieEmpty extends MovieState {}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasData extends MovieState {
  final List<Movie> movieList;

  const MovieListHasData(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class MovieDetailHasData extends MovieState {
  final MovieDetail movieDetail;
  const MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieWatchlistStatus extends MovieState {
  final bool status;

  const MovieWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistMovieMessage extends MovieState {
  final String message;

  const WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}
