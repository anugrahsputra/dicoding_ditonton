import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/tv/search_tv.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([
  SearchTv,
])
void main() {
  late MockSearchTv mockSearchTv;
  late SearchTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTv();
    notifier = SearchTvNotifier(searchTv: mockSearchTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvModel = Tv(
    backdropPath: '/5DUMPBSnHOZsbBv81GFXZXvDpo6.jpg',
    firstAirDate: '2022-10-12',
    genreIds: const [16, 10759, 10765, 35],
    id: 114410,
    name: 'Chainsaw Man',
    originCountry: const ['JP'],
    originalLanguage: 'ja',
    originalName: 'チェンソーマン',
    overview:
        'Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.',
    popularity: 1004.662,
    posterPath: '/npdB6eFzizki0WaZ1OvKcJrWe97.jpg',
    voteAverage: 8.6,
    voteCount: 340,
  );
  final tTvList = <Tv>[tTvModel];
  const tQuery = 'chainsaw man';

  group('search tv', () {
    test(
      "should change state to loading when usecase is called",
      () async {
        // arrange
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        // act
        notifier.fetchTvSearch(tQuery);
        // assert
        expect(notifier.state, RequestState.Loading);
      },
    );
  });

  test("should change search result data when data is gotten successfully",
      () async {
    // arrange
    when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTvSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.searchResult, tTvList);
    expect(listenerCallCount, 2);
  });

  test("should change state to error when data is gotten unsuccessfully",
      () async {
    // arrange
    when(mockSearchTv.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
