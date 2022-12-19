import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/movie_dummy_objects.dart';

class MovieEventFake extends Fake implements MovieEvent {}

class MovieStateFake extends Fake implements MovieState {}

class MockPopularMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMovieBloc {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(MovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(const MovieError('error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
