import 'dart:async';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_number_formats.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback onSearchMovies;
  List<Movie> initialMovies;

  SearchMovieDelegate(
      {required this.onSearchMovies, this.initialMovies = const []});
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debouncedTimer;

  void _onQueryChanged(String query) {
    if (_debouncedTimer?.isActive ?? false) _debouncedTimer?.cancel();
    isLoadingStream.add(true);
    _debouncedTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        //Buscar peliculas y emitir stream
        /*if (query.isEmpty) {
          debounceMovies.add([]);
          return;
        }*/
        final movies = await onSearchMovies(query);
        initialMovies = movies;
        debounceMovies.add(movies);
        isLoadingStream.add(false);
      },
    );
  }

  void clearStreams() {
    debounceMovies.close();
    isLoadingStream.close();
    _debouncedTimer?.cancel();
  }

  /*@override
  String? get searchFieldLabel => super.searchFieldLabel;*/

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          final hasLoded = snapshot.data ?? false;
          if (hasLoded) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              animate: query.isNotEmpty,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }
          return FadeIn(
            duration: const Duration(milliseconds: 200),
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.clear_rounded)),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final isIos = Platform.isIOS;
    return IconButton(
      onPressed: () {
        close(context, null);
        clearStreams();
      },
      icon: Icon(
          isIos ? Icons.arrow_back_ios_new_rounded : Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultSuggestionsList(initialMovies);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
        stream: debounceMovies.stream,
        initialData: initialMovies,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return _buildResultSuggestionsList(movies);
        });
  }

  Widget _buildResultSuggestionsList(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) => _MovieItem(
        movie: initialMovies[index],
        onMovieSelected: (context, movie) {
          close(context, movie);
          clearStreams();
        },
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext, Movie) onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //Image
            SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      movie.posterPath,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return const CircularProgressIndicator.adaptive(
                            strokeWidth: 2,
                          );
                        }
                        return FadeIn(child: child);
                      },
                    ))),

            //Description
            const SizedBox(
              width: 10,
            ),

            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  movie.overview.length > 100
                      ? Text(
                          "${movie.overview.substring(0, 100)}...",
                        )
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage, decimals: 1),
                        style: textStyles.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
