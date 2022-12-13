import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/tv/search_tv.dart';

class SearchTvNotifier extends ChangeNotifier {
  final SearchTv searchTv;

  SearchTvNotifier({required this.searchTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
