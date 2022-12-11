import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter/material.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchListTv = <Tv>[];
  List<Tv> get watchListTv => _watchListTv;

  var _watchListState = RequestState.Empty;
  RequestState get watchListState => _watchListState;

  String _message = '';
  String get message => _message;

  final GetWatchlistTv getWatchlistTv;

  WatchlistTvNotifier({required this.getWatchlistTv});

  Future<void> fetchWatchlistTv() async {
    _watchListState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchListState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchListState = RequestState.Loaded;
        _watchListTv = tvData;
        notifyListeners();
      },
    );
  }
}
