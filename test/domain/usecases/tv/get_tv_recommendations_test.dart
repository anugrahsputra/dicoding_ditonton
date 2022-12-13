import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvRecommendation usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendation(mockTvRepository);
  });

  final tId = 1;
  final tTv = <Tv>[];

  test(
    "should get list of tv recommendaions from the repository",
    () async {
      // arange
      when(mockTvRepository.getTvRecommendations(tId))
          .thenAnswer((_) async => Right(tTv));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(tTv));
    },
  );
}
