import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Este repositorio es inmutable siendo solo Provider
final movieRepositoryProvider = Provider((ref) => MovieRepositoryImplementation(
    movieDatasource: MovieDbDatasourceImplementation(),
  )
);
