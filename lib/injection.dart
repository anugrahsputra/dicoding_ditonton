import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:movie/movie.dart';
import 'package:search/domain/usecases/movie/search_movies.dart';
import 'package:search/domain/usecases/tv/search_tv.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:tv/tv.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient client = await SslPinning.sslPinningContext;

  // bloc
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(locator()),
  );
  locator.registerFactory(
    () => NowPlayingMovieBloc(locator()),
  );
  locator.registerFactory(
    () => PopularMovieBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(locator()),
  );
  locator.registerFactory(
    () => MovieRecommentaionsBloc(locator()),
  );
  locator.registerFactory(
    () => MovieDetailBloc(locator()),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirBloc(locator()),
  );
  locator.registerFactory(
    () => PopularBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedBloc(locator()),
  );
  locator.registerFactory(
    () => TvDetailBloc(locator()),
  );
  locator.registerFactory(
    () => TvRecommendationBloc(locator()),
  );
  locator.registerFactory(() => TvWatchlistBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendation(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton<IOClient>(() => client);
}
