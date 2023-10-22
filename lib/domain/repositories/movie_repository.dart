import 'package:cinemapedia/domain/models/movie.dart';

abstract class MovieRepository {
  
  Future<List<Movie>> getNowPlaying ({ int page = 1 });

}