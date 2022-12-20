import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/tv_dummy_object.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTvWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test(
      'should throw DatabaseException when insert to database is failed',
      () async {
        // arrange
        when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
            .thenThrow(Exception());
        // act
        final call = dataSource.insertTvWatchlist(testTvTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.removeTvWatchlist(testTvTable);

      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenThrow(Exception());

      final call = dataSource.removeTvWatchlist(testTvTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    const tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);

      final result = await dataSource.getTvById(tId);

      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);

      final result = await dataSource.getTvById(tId);

      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TvTable from database', () async {
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);

      final result = await dataSource.getWatchlistTv();

      expect(result, [testTvTable]);
    });
  });
}
