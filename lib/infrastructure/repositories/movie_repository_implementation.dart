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
}
