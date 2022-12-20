import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class OnTheAirBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv onTheAir;

  OnTheAirBloc(this.onTheAir) : super(TvEmpty()) {
    on<OnTheAir>((event, emit) async {
      emit(TvLoading());
      final result = await onTheAir.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });
  }
}

class PopularBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv popular;

  PopularBloc(this.popular) : super(TvEmpty()) {
    on<PopularTv>((event, emit) async {
      emit(TvLoading());
      final result = await popular.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });
  }
}

class TopRatedBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv topRated;

  TopRatedBloc(this.topRated) : super(TvEmpty()) {
    on<TopRatedTv>((event, emit) async {
      emit(TvLoading());
      final result = await topRated.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });
  }
}

class TvRecommendationBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendation tvRecommendations;

  TvRecommendationBloc(this.tvRecommendations) : super(TvEmpty()) {
    on<TvRecommendations>((event, emit) async {
      emit(TvLoading());
      final result = await tvRecommendations.execute(event.id);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail tvDetail;

  TvDetailBloc(this.tvDetail) : super(TvEmpty()) {
    on<TvDetails>((event, emit) async {
      emit(TvLoading());
      final result = await tvDetail.execute(event.id);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvDetailHasData(data));
      });
    });
  }
}

class TvWatchlistBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTv watchlistTv;
  final GetWatchListTvStatus watchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvWatchlistBloc(
    this.watchlistTv,
    this.watchlistTvStatus,
    this.saveWatchlistTv,
    this.removeWatchlistTv,
  ) : super(TvEmpty()) {
    on<WatchlistTv>((event, emit) async {
      emit(TvLoading());
      final result = await watchlistTv.execute();

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });

    on<WatchlistStatusTv>((event, emit) async {
      emit(TvLoading());
      final result = await watchlistTvStatus.execute(event.id);

      emit(TvWatchlistStatus(result));
    });

    on<SaveTvWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await saveWatchlistTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(const WatchlistTvMessage(watchlistAddSuccessMessage));
      });
    });

    on<RemoveTvWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await removeWatchlistTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(const WatchlistTvMessage(watchlistRemoveSuccessMessage));
      });
    });
  }
}
