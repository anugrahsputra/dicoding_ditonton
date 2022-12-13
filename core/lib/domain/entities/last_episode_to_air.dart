import 'package:equatable/equatable.dart';

class LastEpisodeToAir extends Equatable {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.runtime,
    required this.seasonNumber,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final dynamic runtime;
  final int seasonNumber;
  final double voteAverage;
  final int voteCount;

  @override
  // TODO: implement props
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        runtime,
        seasonNumber,
        voteAverage,
        voteCount,
      ];
}
