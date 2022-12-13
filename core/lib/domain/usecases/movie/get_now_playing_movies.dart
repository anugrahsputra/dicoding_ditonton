import 'package:dartz/dartz.dart';

import '/domain/entities/movie/movie.dart';
import '/domain/repositories/movie_repository.dart';
import '../../../utils/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
