import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
