import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  static const name = "MovieScreen";

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Movie Screen: $movieId'),
      ),
    );
  }
}