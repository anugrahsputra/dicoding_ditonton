part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvLoading extends TvState {}

class TvEmpty extends TvState {}

class TvError extends TvState {
  final String message;
  const TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvListHasData extends TvState {
  final List<Tv> tvList;
  const TvListHasData(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class TvDetailHasData extends TvState {
  final TvDetail tvDetail;
  const TvDetailHasData(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class TvWatchlistStatus extends TvState {
  final bool status;

  const TvWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistTvMessage extends TvState {
  final String message;

  const WatchlistTvMessage(this.message);

  @override
  List<Object> get props => [message];
}
