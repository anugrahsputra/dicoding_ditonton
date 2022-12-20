import 'package:core/core.dart';
import 'package:tv/tv.dart';

final testTv = Tv(
  backdropPath: '/5DUMPBSnHOZsbBv81GFXZXvDpo6.jpg',
  firstAirDate: '2022-10-12',
  genreIds: const [16, 10759, 10765, 35],
  id: 114410,
  name: 'Chainsaw Man',
  originCountry: const ['JP'],
  originalLanguage: 'ja',
  originalName: 'チェンソーマン',
  overview:
      'Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes. This is a far cry from reality, however, as Denji is forced by the yakuza into killing devils in order to pay off his crushing debts. Using his pet devil Pochita as a weapon, he is ready to do anything for a bit of cash.',
  popularity: 1004.662,
  posterPath: '/npdB6eFzizki0WaZ1OvKcJrWe97.jpg',
  voteAverage: 8.6,
  voteCount: 340,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: "backdropPath",
  lastEpisodeToAir: const LastEpisodeToAir(
    airDate: "airDate",
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    runtime: 1,
    seasonNumber: 1,
    voteAverage: 1,
    voteCount: 1,
  ),
  name: "name",
  episodeRunTime: const [1],
  firstAirDate: "firstAirDate",
  nextEpisodeToAir: 1,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: const ["originCountry"],
  genres: [
    Genre(id: 1, name: "name"),
  ],
  seasons: const [
    Season(
        airDate: "airDate",
        episodeCount: 1,
        id: 1,
        name: "name",
        overview: "overview",
        posterPath: "posterPath",
        seasonNumber: 1)
  ],
  id: 1,
  originalName: "originalName",
  overview: "overview",
  posterPath: "posterPath",
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: "name",
  overview: "overview",
  posterPath: "posterPath",
);

const testTvTable = TvTable(
  id: 1,
  name: "name",
  posterPath: "posterPath",
  overview: "overview",
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
