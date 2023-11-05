import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Cinemapedia",
                style: textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<Movie?>(
                      query: searchQuery,
                      context: context,
                      delegate: SearchMovieDelegate(
                        onSearchMovies: ref
                            .read(searcedhMoviesProvider.notifier)
                            .searchMoviesByQuery,
                      )).then((movie) {
                    if (movie != null) context.push("$basePathMovie/${movie.id}");
                  });
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
