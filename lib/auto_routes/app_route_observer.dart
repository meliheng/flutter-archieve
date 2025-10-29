import 'package:anims/auto_routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'popup_cubit.dart';

class AppRouteObserver extends AutoRouterObserver {
  final AppRouter router;
  final PopupCubit popupCubit;

  AppRouteObserver(this.router, this.popupCubit);

  void _checkStack() {
    final stackNames = router.stack.map((r) => r.name).toList();
    debugPrint('📦 Current stack: $stackNames');

    if (stackNames.length == 1 && stackNames.first == "MasterRoute") {
      popupCubit.onMasterRouteActive();
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkStack());
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    Future.delayed(const Duration(milliseconds: 500), () => _checkStack());
  }
}
