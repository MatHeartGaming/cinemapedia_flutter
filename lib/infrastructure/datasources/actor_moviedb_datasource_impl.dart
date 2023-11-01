import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/models/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDataSourceImplementation extends ActorsDataSource {
  final _dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDbKey,
    'language': 'en-US',
  }));

  List<Actor> _jsonToActors(Map<String, dynamic> json) {
    final actorDbResponse = CreditsResponse.fromJson(json);
    final List<Actor> actors = actorDbResponse.cast
        .map((actor) => ActorMapper.castDbToEntity(actor))
        .toList();
    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie({required String movieId}) async {
    final response = await _dio.get('/movie/$movieId/credits');
    final actors = _jsonToActors(response.data);
    return actors;
  }
}
