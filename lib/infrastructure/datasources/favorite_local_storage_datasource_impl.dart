
import 'package:cinemapedia/domain/datasources/favorites_local_storage_datasource.dart';
import 'package:cinemapedia/domain/models/movie.dart';

class FavoriteLocalStorageDataSourceImpl extends FavoritesLocalStorageDataSource {

  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

}