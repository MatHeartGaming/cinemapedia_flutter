import 'package:cinemapedia/infrastructure/datasources/favorite_local_storage_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/favorite_local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteLocalStorageRepositoryProvider = Provider((ref) {
  final datasource = FavoriteLocalStorageDataSourceImpl();
  return FavoriteLocalStorageRepositoryImpl(datasource);
});

// Movie Favorite??
final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository =
      ref.watch(favoriteLocalStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});