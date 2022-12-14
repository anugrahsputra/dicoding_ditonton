import 'package:dartz/dartz.dart';

import '../../../../domain/entities/tv/tv.dart';
import '../../../../domain/repositories/tv_repository.dart';
import '../../../utils/failure.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
