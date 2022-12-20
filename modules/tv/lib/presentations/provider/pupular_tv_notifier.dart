import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv/tv.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTv getPopularTv;

  PopularTvNotifier(this.getPopularTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _popularTv = [];
  List<Tv> get popularTv => _popularTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _popularTv = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
