import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
