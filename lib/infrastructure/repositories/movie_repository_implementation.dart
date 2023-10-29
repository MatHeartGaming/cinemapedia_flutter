import 'package:cinemapedia/domain/datasources/movie_datasource.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/domain/repositories/movie_repository.dart';

class MovieRepositoryImplementation extends MovieRepository {
  final MovieDatasource movieDatasource;

  MovieRepositoryImplementation({required this.movieDatasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return movieDatasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return movieDatasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return movieDatasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return movieDatasource.getTopRated(page: page);
  }
}
