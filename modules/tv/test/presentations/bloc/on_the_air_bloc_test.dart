import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/presentations/bloc/tv_bloc.dart';

import '../../dummy_data/tv/tv_dummy_object.dart';
import 'on_the_air_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late OnTheAirBloc onTheAirBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    onTheAirBloc = OnTheAirBloc(mockGetNowPlayingTv);
  });

  test(
    'initial state should be empty',
    () {
      expect(onTheAirBloc.state, TvEmpty());
    },
  );

  blocTest<OnTheAirBloc, TvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return onTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTheAir()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );

  blocTest<OnTheAirBloc, TvState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTheAir()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );
}
