import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
