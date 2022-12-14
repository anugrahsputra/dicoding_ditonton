import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: 'backdropPath',
    firstAirDate: '2022-10-12',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: '2022-10-12',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test(
    "should be a subclass of Tv entity",
    () async {
      final result = tTvModel.toEntity();
      expect(result, tTv);
    },
  );
}
