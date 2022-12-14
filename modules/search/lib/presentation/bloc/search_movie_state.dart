part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object?> get props => [];
}

class SearchMovieEmpty extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final String message;
  const SearchMovieError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class SearchMovieHasData extends SearchMovieState {
  final List<Movie> result;
  const SearchMovieHasData(this.result);

  @override
  List<Object?> get props => [result];
}
