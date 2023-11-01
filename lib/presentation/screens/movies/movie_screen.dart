import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/models/movie.dart';
import 'package:cinemapedia/presentation/providers/actors/initial_loading_actors_provders.dart';
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
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(actorsByMovieProvider).clear();
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
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) return const SizedBox();
                    return FadeIn(child: child);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: colors.primary),),
                    Text(
                      movie.overview,
                      textAlign: TextAlign.justify,
                      style: textStyle.bodyMedium
                          ?.copyWith(color: colors.secondary),
                    ),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )),
          ]),
        ),

        _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialLoadingIsEmpty = ref.watch(initialLoadingActorsProvider);
    if (initialLoadingIsEmpty) {
      return const CircularProgressIndicator.adaptive(
        strokeWidth: 2,
      );
    }
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    final actors = actorsByMovie[movieId];
    final textStyle = Theme.of(context).textTheme;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors?.length ?? 0,
        itemBuilder: (context, index) {
          final actor = actors![index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Actor photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: textStyle.labelSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
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
                loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) return const SizedBox();
                    return FadeIn(child: child);
                  },
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
