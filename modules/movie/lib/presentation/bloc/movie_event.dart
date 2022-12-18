part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class NowPlayingMovie extends MovieEvent {}

class PopularMovie extends MovieEvent {}

class TopRatedMovie extends MovieEvent {}

class MovieRecommendations extends MovieEvent {
  final int id;
  const MovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class MovieDetails extends MovieEvent {
  final int id;

  const MovieDetails(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistMovie extends MovieEvent {}

class WatchlistStatusMovie extends MovieEvent {
  final int id;

  const WatchlistStatusMovie(this.id);

  @override
  List<Object> get props => [id];
}

class SaveWatchlistMovie extends MovieEvent {
  final MovieDetail movieDetail;
  const SaveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlistMovie extends MovieEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
