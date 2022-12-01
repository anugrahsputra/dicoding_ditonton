import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;
  Tv({
    this.backdropPath,
    this.firstAirDate,
    required this.genreIds,
    this.id,
    this.name,
    required this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  Tv.watchlist({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
