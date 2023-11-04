import 'package:cinemapedia/config/constants/app_constants.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: movieDB.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
          : posterNotFoundUrl,
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: movieDB.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
          : posterNotFoundUrl,
      //: 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
      adult: movie.adult,
      backdropPath: movie.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
          : posterNotFoundUrl,
      genreIds: movie.genres.map((e) => e.name).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: movie.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
          : posterNotFoundUrl,
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount);
}
