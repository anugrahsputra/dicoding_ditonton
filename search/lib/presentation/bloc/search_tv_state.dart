part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object?> get props => [];
}

class SearchTvEmpty extends SearchTvState {}

class SearchTvLoading extends SearchTvState {}

class SearchTvError extends SearchTvState {
  final String message;
  const SearchTvError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class SearchTvHasData extends SearchTvState {
  final List<Tv> result;
  const SearchTvHasData(this.result);

  @override
  List<Object?> get props => [result];
}
