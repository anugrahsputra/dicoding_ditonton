import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/movie_dummy_objects.dart';

class MovieEventFake extends Fake implements MovieEvent {}

class MovieStateFake extends Fake implements MovieState {}

class MockMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieRecommentaionsBloc {}

class MockMovieWatchlistBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieWatchlistBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockMovieWatchlistBloc,
        ),
        BlocProvider<MovieRecommentaionsBloc>(
          create: (context) => mockMovieRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display check icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(true));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        const WatchlistMovieMessage(
            MovieWatchlistBloc.watchlistAddSuccessMessage));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(MovieWatchlistBloc.watchlistAddSuccessMessage),
        findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
