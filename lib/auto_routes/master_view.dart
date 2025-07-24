import 'package:anims/auto_routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MasterView extends StatelessWidget {
  const MasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [const HomeRoute(), const ProfileRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
