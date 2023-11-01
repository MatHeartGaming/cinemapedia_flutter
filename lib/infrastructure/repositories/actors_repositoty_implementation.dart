import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/models/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImplementation extends ActorsRepository {
  final ActorsDataSource actorsDataSource;

  ActorsRepositoryImplementation({required this.actorsDataSource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorsDataSource.getActorsByMovie(movieId: movieId);
  }
}
