import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetPopularTv {
  final TvRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
