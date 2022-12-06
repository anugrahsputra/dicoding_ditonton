import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=8c2288634235370aeb1e214778675bf3';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('/dummy_data/now_playing_tv.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('/dummy_data/now_playing_tv.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTv();
      // assert
      expect(result, equals(tTvList));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getNowPlayingTv();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
