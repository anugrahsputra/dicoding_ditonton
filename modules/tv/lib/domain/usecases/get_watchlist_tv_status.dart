import 'package:tv/tv.dart';

class GetWatchListTvStatus {
  final TvRepository repository;

  GetWatchListTvStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
