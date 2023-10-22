import 'package:cinemapedia/domain/models/movie.dart';

abstract class MovieDatasource {
  
  Future<List<Movie>> getNowPlaying ({ int page = 1 });

}
