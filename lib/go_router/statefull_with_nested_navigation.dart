// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({Key? key, required this.navigationShell})
    : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    print('goBranch: $index');
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xffe8edf2), width: 1)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          destinations: [
            _NavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
              isActive: navigationShell.currentIndex == 0,
              onTap: () => _goBranch(0),
            ),
            _NavItem(
              icon: Icons.add,
              label: 'Add',
              index: 1,
              isActive: navigationShell.currentIndex == 1,
              onTap: () => _goBranch(1),
            ),
            _NavItem(
              icon: Icons.report,
              label: 'Report',
              index: 2,
              isActive: navigationShell.currentIndex == 2,
              onTap: () => _goBranch(2),
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Profile',
              index: 3,
              isActive: navigationShell.currentIndex == 3,
              onTap: () => _goBranch(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.onTap,
    this.isActive = false,
  });
  final IconData icon;
  final String label;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.black : Color(0xff4f7896),
              size: 30,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.black : Color(0xff4f7896),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
