// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationAppbar extends StatelessWidget {
  const NavigationAppbar({Key? key}) : super(key: key);
  int getCurrentIndex(BuildContext context) {
    final String location = GoRouter.of(context).location;
    switch (location) {
      case '/':
        return 0;
      case '/favoriscreen':
        return 1;
      case '/gpsscreen':
        return 2;
      case '/perfilscreen':
        return 3;
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
        context.go('/favoriscreen');
        break;
      case 2:
        context.go('/gpsscreen');
        break;
      case 3:
        context.go('/perfilscreen');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      onTap: (value) => onItemTapped(context, value),
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.green.shade300,
          icon: const Icon(Icons.home_max),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.green.shade300,
          icon: const Icon(Icons.favorite_border_rounded),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.green.shade300,
          icon: const Icon(Icons.fmd_good_sharp),
          label: 'Ubicacion',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.green.shade300,
          icon: const Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}