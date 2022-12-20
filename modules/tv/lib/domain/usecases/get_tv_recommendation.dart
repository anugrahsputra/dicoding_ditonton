import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTvRecommendation {
  final TvRepository repository;

  GetTvRecommendation(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return repository.getTvRecommendations(id);
  }
}
