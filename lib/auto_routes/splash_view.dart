import 'package:anims/auto_routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text('Splash View'),
            FlutterLogo(size: 100),
            ElevatedButton(
              onPressed: () {
                context.router.replaceAll([MasterRoute()]);
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
