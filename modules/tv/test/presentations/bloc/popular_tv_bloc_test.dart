import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentations/bloc/tv_bloc.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/tv_dummy_object.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularBloc(mockGetPopularTv);
  });

  test('initial state should be empty', () {
    expect(popularTvBloc.state, TvEmpty());
  });

  blocTest<PopularBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
