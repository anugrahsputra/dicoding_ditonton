import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class RemoveWatchlistTv {
  final TvRepository repository;
  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
