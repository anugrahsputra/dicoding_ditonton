import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final GetNowPlayingTv getNowPlayingTv;
  OnTheAirTvNotifier(
    this.getNowPlayingTv,
  );

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _onTheAirTv = [];
  List<Tv> get tv => _onTheAirTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _onTheAirTv = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
