import 'package:cinemapedia/domain/models/movie.dart';

abstract class FavoritesLocalStorageDataSource {
  Future<bool> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}
