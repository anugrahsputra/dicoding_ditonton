import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_object.dart';

class TvEvenFake extends Fake implements TvEvent {}

class TvStateFake extends Fake implements TvState {}

class MockTvDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvDetailBloc {}

class MockTvRecommendationsBloc extends MockBloc<TvEvent, TvState>
    implements TvRecommendationBloc {}

class MockTvWatchlistBloc extends MockBloc<TvEvent, TvState>
    implements TvWatchlistBloc {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
    registerFallbackValue(TvEvenFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => mockTvDetailBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => mockTvWatchlistBloc,
        ),
        BlocProvider<TvRecommendationBloc>(
          create: (context) => mockTvRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvListHasData(testTvList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(true));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvListHasData(testTvList));

    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvListHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));
    when(() => mockTvWatchlistBloc.state).thenReturn(
        const WatchlistTvMessage(TvWatchlistBloc.watchlistAddSuccessMessage));

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(
        find.text(TvWatchlistBloc.watchlistAddSuccessMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvListHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));
    when(() => mockTvWatchlistBloc.state).thenReturn(const TvError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
