import 'package:dartz/dartz.dart';

import '../../../../domain/entities/tv/tv_detail.dart';
import '../../../../domain/repositories/tv_repository.dart';
import '../../../utils/failure.dart';

class RemoveWatchlistTv {
  final TvRepository repository;
  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
