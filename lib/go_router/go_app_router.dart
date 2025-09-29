import 'package:anims/go_router/add_view.dart';
import 'package:anims/go_router/report_view.dart';
import 'package:anims/go_router/statefull_with_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_view.dart';
import 'profile_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeView()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/add', builder: (context, state) => const AddView()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/report',
              builder: (context, state) => const ReportView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
