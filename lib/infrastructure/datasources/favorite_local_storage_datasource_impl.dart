import 'package:cinemapedia/domain/datasources/favorites_local_storage_datasource.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class FavoriteLocalStorageDataSourceImpl
    extends FavoritesLocalStorageDataSource {
  late Future<Isar> db;

  FavoriteLocalStorageDataSourceImpl() {
    db = _openDB();
  }

  Future<Isar> _openDB() async {
    final appDirectory = await getApplicationCacheDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], directory: appDirectory.path);
    }
    return Future.value(Isar.getInstance());
  }

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
