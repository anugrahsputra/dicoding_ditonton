import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class NowPlayingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies nowPlayingMovies;

  NowPlayingMovieBloc(this.nowPlayingMovies) : super(MovieEmpty()) {
    on<NowPlayingMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await nowPlayingMovies.execute();

      result.fold((failure) {
        emit(MovieError(failure.message));
      }, (data) {
        emit(MovieListHasData(data));
      });
    });
  }
}

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies popularMovies;

  PopularMovieBloc(this.popularMovies) : super(MovieEmpty()) {
    on<PopularMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await popularMovies.execute();

      result.fold((failure) => emit(MovieError(failure.message)),
          (data) => emit(MovieListHasData(data)));
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies topRatedMovies;

  TopRatedMovieBloc(this.topRatedMovies) : super(MovieEmpty()) {
    on<TopRatedMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await topRatedMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieListHasData(data)),
      );
    });
  }
}

class MovieRecommentaionsBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations movieRecommendations;

  MovieRecommentaionsBloc(this.movieRecommendations) : super(MovieEmpty()) {
    on<MovieRecommendations>((event, emit) async {
      emit(MovieLoading());
      final result = await movieRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieListHasData(data)),
      );
    });
  }
}

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail movieDetail;

  MovieDetailBloc(this.movieDetail) : super(MovieEmpty()) {
    on<MovieDetails>((event, emit) async {
      emit(MovieLoading());
      final result = await movieDetail.execute(event.id);

      result.fold((failure) {
        emit(MovieError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });
  }
}

class MovieWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies watchlistMovies;
  final GetWatchListStatus watchListStatus;
  final SaveWatchlist saveWatchlistMovie;
  final RemoveWatchlist removeWatchlistMovie;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc(
    this.watchlistMovies,
    this.watchListStatus,
    this.saveWatchlistMovie,
    this.removeWatchlistMovie,
  ) : super(MovieEmpty()) {
    on<WatchlistMovie>((event, emit) async {
      emit(MovieLoading());

      final result = await watchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieListHasData(data)),
      );
    });

    on<WatchlistStatusMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await watchListStatus.execute(event.id);
      emit(MovieWatchlistStatus(result));
    });

    on<SaveWatchlistMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await saveWatchlistMovie.execute(event.movieDetail);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (success) => emit(WatchlistMovieMessage(success)),
      );
    });
    on<RemoveWatchlistMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await removeWatchlistMovie.execute(event.movieDetail);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (success) => emit(WatchlistMovieMessage(success)),
      );
    });
  }
}
