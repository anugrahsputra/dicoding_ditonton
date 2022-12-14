import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/domain/usecases/movie/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchMovieEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchMovieLoading());
      final result = await _searchMovies.execute(query);

      result.fold((failure) {
        emit(SearchMovieError(failure.message));
      }, (data) {
        emit(SearchMovieHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
