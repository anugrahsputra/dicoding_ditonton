import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
