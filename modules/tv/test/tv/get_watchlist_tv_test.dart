import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../dummy_data/tv/tv_dummy_object.dart';
import '../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTv(mockTvRepository);
  });

  test(
    "should get list of tv from the repository",
    () async {
      // arrange
      when(mockTvRepository.getWatchlistTv())
          .thenAnswer((_) async => Right(testTvList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvList));
    },
  );
}
