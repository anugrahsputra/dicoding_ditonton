import 'package:dartz/dartz.dart';

import '../../../../domain/entities/tv/tv.dart';
import '../../../../domain/repositories/tv_repository.dart';
import '../../../utils/failure.dart';

class GetTvRecommendation {
  final TvRepository repository;

  GetTvRecommendation(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return repository.getTvRecommendations(id);
  }
}
