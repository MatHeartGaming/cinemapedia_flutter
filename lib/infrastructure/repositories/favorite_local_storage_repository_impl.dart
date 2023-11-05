import 'package:cinemapedia/domain/datasources/favorites_local_storage_datasource.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/domain/repositories/favorites_local_storage_repository.dart';

class FavoriteLocalStorageRepositoryImpl
    extends FavoritesLocalStorageRepository {
  final FavoritesLocalStorageDataSource dataSource;

  FavoriteLocalStorageRepositoryImpl(this.dataSource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return dataSource.toggleFavorite(movie);
  }
}
