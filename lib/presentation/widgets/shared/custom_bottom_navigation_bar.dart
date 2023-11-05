import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/$index');
        break;

      case 1:
        context.go('/home/$index');
        break;

      case 2:
        context.go('/home/$index');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (tappedIndex) => _onItemTapped(context, tappedIndex),
        currentIndex: currentIndex,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Inicio",
            icon: Icon(Icons.home_max),
          ),
          BottomNavigationBarItem(
            label: "Categorias",
            icon: Icon(Icons.label_outline),
          ),
          BottomNavigationBarItem(
            label: "Favoritos",
            icon: Icon(Icons.favorite_outline),
          ),
        ]);
  }
}
