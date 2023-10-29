import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});

  final messages = <String>[
    'Cargando peliculas',
    'Comprando palomitas de mais',
    'Cargando populares',
    'Llamando a mi novia',
    'Ya mero...',
    'Ya queda poco...',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Espere por favor"),
        const SizedBox(
          height: 10,
        ),
        const CircularProgressIndicator.adaptive(
          strokeWidth: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Cargando...");
            }
            return Text(snapshot.data!);
          },
        )
      ],
    ));
  }
}
