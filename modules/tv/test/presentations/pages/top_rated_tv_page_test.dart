import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_object.dart';

class TvEvenFake extends Fake implements TvEvent {}

class TvStateFake extends Fake implements TvState {}

class MockTopRatedTvBloc extends MockBloc<TvEvent, TvState>
    implements TopRatedBloc {}

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
    registerFallbackValue(TvEvenFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopRatedBloc>(
          create: (context) => mockTopRatedTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TvListHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(const TvError('error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
