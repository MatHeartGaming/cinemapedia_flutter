import 'package:cinemapedia/domain/datasources/favorites_local_storage_datasource.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/domain/repositories/favorites_local_storage_repository.dart';

class FavoriteLocalStorageRepositoryImpl
    extends FavoritesLocalStorageRepository {
  final FavoritesLocalStorageDataSource dataSource;

  FavoriteLocalStorageRepositoryImpl(this.dataSource);

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    return await dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    return await dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<bool> toggleFavorite(Movie movie) async {
    return await dataSource.toggleFavorite(movie);
  }
}
