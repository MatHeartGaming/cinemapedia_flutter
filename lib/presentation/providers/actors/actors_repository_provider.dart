import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/actors_repositoty_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) =>
    ActorsRepositoryImplementation(actorsDataSource: ActorMovieDbDataSourceImplementation()));
