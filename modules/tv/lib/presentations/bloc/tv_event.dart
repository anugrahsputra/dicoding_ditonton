part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class OnTheAir extends TvEvent {}

class PopularTv extends TvEvent {}

class TopRatedTv extends TvEvent {}

class TvRecommendations extends TvEvent {
  final int id;
  const TvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class TvDetails extends TvEvent {
  final int id;

  const TvDetails(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistTv extends TvEvent {}

class WatchlistStatusTv extends TvEvent {
  final int id;

  const WatchlistStatusTv(this.id);

  @override
  List<Object> get props => [id];
}

class SaveTvWatchlist extends TvEvent {
  final TvDetail tvDetail;
  const SaveTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveTvWatchlist extends TvEvent {
  final TvDetail tvDetail;

  const RemoveTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
