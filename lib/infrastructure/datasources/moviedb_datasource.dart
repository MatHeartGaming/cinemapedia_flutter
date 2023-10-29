import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movie_datasource.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDbDatasourceImplementation extends MovieDatasource {
  final _dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDbKey,
    'language': 'en-US',
  }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDbResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((m) => MovieMapper.movieDbToEntity(m))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await _dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    final movies = _jsonToMovies(response.data);
    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await _dio.get('/movie/popular', queryParameters: {
      'page': page,
    });
    final movies = _jsonToMovies(response.data);
    return movies;
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await _dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });
    final movies = _jsonToMovies(response.data);
    return movies;
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await _dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    final movies = _jsonToMovies(response.data);
    return movies;
  }

}
