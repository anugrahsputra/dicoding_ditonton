import 'package:dartz/dartz.dart';

import '/domain/entities/movie/movie.dart';
import '/domain/repositories/movie_repository.dart';
import '../../../utils/failure.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
