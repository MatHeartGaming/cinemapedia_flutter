
import 'package:cinemapedia/domain/models/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie({required String movieId});
}