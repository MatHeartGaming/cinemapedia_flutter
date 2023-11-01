import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = "MovieScreen";

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Movie> movieMap = ref.watch(movieInfoProvider);
    final Movie? movie = movieMap[widget.movieId];
    return Scaffold(
        body: (movie == null)
            ? const Center(child: CircularProgressIndicator.adaptive())
            : CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  _CustomSliverAppBar(
                    movie: movie,
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => _MovieDetails(
                                movie: movie,
                              ),
                          childCount: 1)),
                ],
              ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: colors.primary),),
                    Text(movie.overview, textAlign: TextAlign.justify, style: textStyle.bodyMedium?.copyWith(
                      color: colors.secondary
                    ),),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Generos peli
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(children: [
            ...movie.genreIds.map((genre) => Container(
              margin: const EdgeInsets.only(right: 8),
              child: Chip(
                label: Text(genre),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            )),
          ]),
        ),

        // TODO: Mostar Actores en ListView

        const SizedBox(height: 100,),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox.expand(
                child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, stops: [
                  0.0,
                  0.35
                ], colors: [
                  Colors.black87,
                  Colors.transparent,
                ]),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
