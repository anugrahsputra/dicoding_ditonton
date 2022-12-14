import 'package:dartz/dartz.dart';

import '../../../../domain/entities/tv/tv.dart';
import '../../../../domain/repositories/tv_repository.dart';
import '../../../utils/failure.dart';

class GetPopularTv {
  final TvRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
