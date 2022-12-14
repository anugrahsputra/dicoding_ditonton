import 'package:dartz/dartz.dart';

import '../../../../domain/entities/tv/tv.dart';
import '../../../../domain/repositories/tv_repository.dart';
import '../../../utils/failure.dart';

class GetWatchlistTv {
  final TvRepository repository;

  GetWatchlistTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTv();
  }
}
