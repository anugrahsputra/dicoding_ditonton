import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

import '../../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-09-26',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: '/path.jpg',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvResponseModel = const TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test(
      "should return a valid model from JSON",
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(readJson('dummy_data/now_playing_tv.json'));
        // act
        final result = TvResponse.fromJson(jsonMap);
        // assert
        expect(result, tTvResponseModel);
      },
    );
  });

  group('toJson', () {
    test("should return a JSON map containing proper data", () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2022-09-26",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "name",
            "origin_country": ["originCountry"],
            "original_language": "originalLanguage",
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1,
            "poster_path": "/path.jpg",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
