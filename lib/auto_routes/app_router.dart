import 'package:anims/auto_routes/home_view.dart';
import 'package:anims/auto_routes/master_view.dart';
import 'package:anims/auto_routes/profile_detail_view.dart';
import 'package:anims/auto_routes/profile_view.dart';
import 'package:anims/auto_routes/settings_detail_view.dart';
import 'package:anims/auto_routes/settings_view.dart';
import 'package:anims/auto_routes/settings_wrapper.dart';
import 'package:anims/views/result_view.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: MasterRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(
          page: SettingsWrapper2.page,
          path: 'settings',
          children: [
            AutoRoute(
              page: SettingsRoute.page,
              path: 'settings',
              initial: true,
            ),
            AutoRoute(page: SettingsDetailRoute.page, path: 'settings/detail'),
          ],
        ),
      ],
    ),
    AutoRoute(page: ProfileDetailRoute.page, path: '/profile/detail'),
    AutoRoute(page: ResultRoute.page, path: '/result'),
  ];
}
