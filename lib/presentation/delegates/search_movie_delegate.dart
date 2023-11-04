import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_number_formats.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback onSearchMovies;

  SearchMovieDelegate({required this.onSearchMovies});

  /*@override
  String? get searchFieldLabel => super.searchFieldLabel;*/

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        duration: const Duration(milliseconds: 200),
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear_rounded)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final isIos = Platform.isIOS;
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
          isIos ? Icons.arrow_back_ios_new_rounded : Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("Results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: onSearchMovies(query),
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
          );
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Padding(
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
                    ? Text("${movie.overview.substring(0, 100)}...",)
                    : Text(movie.overview),

                Row(
                  children: [
                    Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                    const SizedBox(width: 5,),
                    Text(HumanFormats.number(movie.voteAverage, decimals: 1), 
                      style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade900),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
