import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

const String basePath = '/home/0';

final appRouter = GoRouter(
  initialLocation: basePath,
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return HomeScreen(pageIndex: int.parse(pageIndex));
        },
        routes: [
          GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              }),
        ]),
    GoRoute(
      path: '/',
      redirect: (_, __) => basePath,
    ),
  ],
);
