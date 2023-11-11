import 'package:cinemapedia/domain/datasources/favorites_local_storage_datasource.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class FavoriteLocalStorageDataSourceImpl
    extends FavoritesLocalStorageDataSource {
  late Future<Isar> _db;

  FavoriteLocalStorageDataSourceImpl() {
    _db = _openDB();
  }

  Future<Isar> _openDB() async {
    final appDirectory = await getApplicationCacheDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], directory: appDirectory.path);
    }
    return await Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await _db;
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await _db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<bool> toggleFavorite(Movie movie) async {
    final isar = await _db;
    bool favoriteMovie = await isMovieFavorite(movie.id);
    if (favoriteMovie) {
      //Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(movie.isarId));
      return false;
    }

    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
    return true;
  }
}
