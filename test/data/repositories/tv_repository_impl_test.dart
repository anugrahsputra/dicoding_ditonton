import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/other/genre_model.dart';
import 'package:ditonton/data/models/other/created_by_model.dart';

import 'package:ditonton/data/models/other/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/other/season_model.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv/tv_dummy_object.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      localDataSource: mockTvLocalDataSource,
      remoteDataSource: mockTvRemoteDataSource,
    );
  });

  final tTvModel = TvModel(
    backdropPath: '/5DUMPBSnHOZsbBv81GFXZXvDpo6.jpg',
    firstAirDate: '2022-10-12',
    genreIds: [16, 10759, 10765, 35],
    id: 114410,
    name: 'Chainsaw Man',
    originCountry: ['JP'],
    originalLanguage: 'ja',
    originalName: 'チェンソーマン',
    overview:
        'Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.',
    popularity: 1004.662,
    posterPath: '/npdB6eFzizki0WaZ1OvKcJrWe97.jpg',
    voteAverage: 8.6,
    voteCount: 340,
  );

  final tTv = Tv(
    backdropPath: '/5DUMPBSnHOZsbBv81GFXZXvDpo6.jpg',
    firstAirDate: '2022-10-12',
    genreIds: [16, 10759, 10765, 35],
    id: 114410,
    name: 'Chainsaw Man',
    originCountry: ['JP'],
    originalLanguage: 'ja',
    originalName: 'チェンソーマン',
    overview:
        'Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.',
    popularity: 1004.662,
    posterPath: '/npdB6eFzizki0WaZ1OvKcJrWe97.jpg',
    voteAverage: 8.6,
    voteCount: 340,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Now Playing Tv', () {
    test(
      "should return remote data when the call to remote data source is successfull",
      () async {
        // arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.getNowPlayingTv();
        // assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
      "should return connection failure when the device is not connected to internet",
      () async {
        // arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getNowPlayingTv();
        // assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });

  group('Popular Tv', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Detail', () {
    final tId = 1;
    final tTvResponse = TvDetailResponse(
      backdropPath: 'backdropPath',
      createdBy: [
        CreatedByModel(
            id: 1,
            creditId: 'creditId',
            name: 'name',
            gender: 1,
            profilePath: 'profilePath')
      ],
      episodeRunTime: [1],
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'name')],
      homepage: 'homepage',
      id: 1,
      inProduction: true,
      languages: ['languages'],
      lastAirDate: 'lastAirDate',
      lastEpisodeToAir: LastEpisodeToAirModel(
        airDate: 'airDate',
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        runtime: 1,
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1,
      ),
      name: 'name',
      nextEpisodeToAir: 1,
      networks: ['networks'],
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      productionCompanies: ['productionCompanies'],
      productionCountries: ['productionCountries'],
      seasons: [
        SeasonModel(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        )
      ],
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Tv datta when the call to remote data source is successful',
        () async {
      // arrang
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Recommendation', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test(
      "should return data (tv list) when the call is successful",
      () async {
        // arrange
        when(mockTvRemoteDataSource.getTvRecommendations(tId))
            .thenAnswer((_) async => tTvList);
        // act
        final result = await repository.getTvRecommendations(tId);
        // assert
        verify(mockTvRemoteDataSource.getTvRecommendations(tId));
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvList));
      },
    );

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Search Tv', () {
    final tQuery = 'chainsaw man';

    test(
      "should return tv list when call to data source is successful",
      () async {
        // arrange
        when(mockTvRemoteDataSource.searchTv(tQuery))
            .thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.searchTv(tQuery);
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      },
    );

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from Watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
