import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentations/bloc/tv_bloc.dart';

import '../../dummy_data/tv/tv_dummy_object.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  test(
    'initial state should be empty',
    () {
      expect(tvDetailBloc.state, TvEmpty());
    },
  );

  blocTest<TvDetailBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const TvDetails(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(1));
    },
  );

  blocTest<TvDetailBloc, TvState>(
    'should emit [Loading, Error] when get tv detail is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const TvDetails(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(1));
    },
  );
}
