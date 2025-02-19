import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  final String currentLocation;

  MainScreen({super.key, required this.child, required this.currentLocation});

  final List<String> _routes = ['/', '/bias'];

  int _calculateSelectedIndex() {
    return _routes.indexWhere((route) => currentLocation.startsWith(route));
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = _calculateSelectedIndex();

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex == -1 ? 0 : selectedIndex,
        onTap: (index) {
          context.go(_routes[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
