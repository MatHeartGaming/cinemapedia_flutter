import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/domain/repositories/favorites_local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/storage/favorite_local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final repository = ref.watch(favoriteLocalStorageRepositoryProvider);
  return StorageMoviesNotifier(repository: repository);
});

/*
{
  1234: Movie,
  1235: Movie,
  1236: Movie,
}
*/

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int _page = 0;
  final FavoritesLocalStorageRepository repository;

  StorageMoviesNotifier({required this.repository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await repository.loadMovies(offset: _page * 10, limit: 20);
    _page++;
    final tempMoviesMap = <int, Movie>{};

    // En el video
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    // This does not work!
    //movies.map((m) => tempMoviesMap[m.id] = m);

    state = {...state, ...tempMoviesMap};
    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    final isMovieInFavorites = await repository.toggleFavorite(movie);
    if (isMovieInFavorites) {
      // It was favorite, so we remove it from favorites
      state.remove(movie.id);
      state = {...state};
      return;
    }
    // It wasn't fav, so we add it
    state = {...state, movie.id: movie};
  }
}
