import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        body: Visibility(
      visible: favoriteMovies.isNotEmpty,
      replacement: _emptyFavoritesWidget(colors),
      child: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: _loadNextPage,
      ),
    ));
  }

  Widget _emptyFavoritesWidget(ColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline_rounded, size: 60, color: colors.primary,),
          Text("Ooh No!", style: TextStyle(fontSize: 20, color: colors.primary),),
          const Text("No tienes peliuclas favoritas 😔", style: TextStyle(fontSize: 20, color: Colors.black45),),
          const SizedBox(height: 20,),
          FilledButton.tonal(
            onPressed: () => context.go(basePath), 
            child: const Text("Añade una peli ♥︎")),
        ],
      ),
    );
  }
}
