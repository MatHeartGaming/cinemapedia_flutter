import 'package:cinemapedia/domain/models/actor.dart';

abstract class ActorsDataSource {
  Future<List<Actor>> getActorsByMovie({required String movieId});
}
