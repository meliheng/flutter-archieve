import 'package:anims/auto_routes/deneme_view.dart';
import 'package:anims/auto_routes/home_view.dart';
import 'package:anims/auto_routes/master_view.dart';
import 'package:anims/auto_routes/paywall_view.dart';
import 'package:anims/auto_routes/profile_detail_view.dart';
import 'package:anims/auto_routes/profile_view.dart';
import 'package:anims/auto_routes/settings_detail_view.dart';
import 'package:anims/auto_routes/settings_view.dart';
import 'package:anims/auto_routes/splash_view.dart';
import 'package:anims/views/result_view.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),
    AutoRoute(page: PaywallRoute.page, path: '/paywall'),
    AutoRoute(page: DenemeRoute.page, path: '/deneme'),
    CustomRoute(
      page: MasterRoute.page,
      path: '/master',
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(
          page: SettingsRoute.page,
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
