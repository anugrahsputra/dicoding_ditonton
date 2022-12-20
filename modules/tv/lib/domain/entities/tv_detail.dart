import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/last_episode_to_air.dart';
import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.backdropPath,
    required this.lastEpisodeToAir,
    required this.name,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.genres,
    required this.seasons,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final LastEpisodeToAir lastEpisodeToAir;
  final String name;
  final List<dynamic> episodeRunTime;
  final String firstAirDate;
  final dynamic nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<dynamic> originCountry;
  final List<Genre> genres;
  final List<Season> seasons;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        lastEpisodeToAir,
        episodeRunTime,
        name,
        firstAirDate,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        genres,
        seasons,
        id,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
