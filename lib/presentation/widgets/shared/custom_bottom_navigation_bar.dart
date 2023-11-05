import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case '/':
        return 0;
      case '/categorias':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;

      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (value) => onItemTapped(context, value),
        currentIndex: getCurrentIndex(context),
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
